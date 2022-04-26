#!/bin/bash

/bin/echo "[po_directory] po
[options] -M UTF-8 -L UTF-8 -A UTF-8 --master-language en --msgmerge-opt '--no-wrap' --porefs file --wrap-po no
[po4a_alias:markdown] text -o markdown -o neverwrap -o nobullets -k 90" > "./po4a.conf"

shopt -s nullglob
shopt -s globstar

for file in source/**/*.md; do
    filename=${file##*/}
    filename=${filename%%\.*}
    folder=${file#*/}
    folder=/${folder#*/}
    folder=${folder%/*}
    repo=${file#*/}
    repo=${repo%%/*}

    headre="^\&#820[6,7];"
    if [[ $(sed '3q;d' $file) =~ $headre ]]; then
        sed -i '2,3d' $file
    fi

    /bin/echo "[type:markdown] $file \$lang:i18n/$repo/\$lang$folder/$filename.md" >> "./po4a.conf"
    cp $file source/$repo$folder/en_${filename}_en.md
    /bin/echo "[type:markdown] source/$repo$folder/en_${filename}_en.md en:i18n/$repo/en$folder/$filename.md opt:\"-k 0\"" >> "./po4a.conf"
done

/bin/echo "[type:yaml] source/titles/titles.yaml \$lang:i18n/titles/\$lang/titles.yaml opt:\"-k 0\"" >> "./po4a.conf"

if [ -d ./i18n ]; then
    rm -R ./i18n
fi

po4a ./po4a.conf -f -v

for file in source/**/en_*_en.md; do
    rm $file
done
sed -i "/en_.*_en\.md/d" ./po4a.conf

po4a ./po4a.conf -f -v --no-translations

sed -i '1d' ./i18n/**/*.yaml
sed -i "s/\(.*:.*\)'\(.*\)'/\1\2/g" ./i18n/titles/*/titles.yaml

find ./i18n -type d -empty -delete

for file in i18n/**/*.md; do
    filename=${file##*/}
    filename=${filename%%\.*}
    postlang=${file#*/}
    postlang=${postlang#*/}
    postlang=/${postlang#*/}
    postlang=${postlang%/*}
    lang=${file#*/}
    lang=${lang#*/}
    lang=${lang%%/*}
    repo=${file#*/}
    repo=${repo%%/*}

    dirre="<div[[:space:]]dir=\"([lrt]{3})\"[[:space:]]align=\"([efghilrt]{4,5})\">"
    if [[ $(sed '1q;d' $file) =~ $dirre ]]; then
        if [[ ${BASH_REMATCH[1]} == "ltr" ]]; then
            dir="\&#8206;"
        else
            dir="\&#8207;"
        fi
    fi

    sed -i "3s/^/\n/" $file

    for link in i18n/$repo/*$postlang/$filename.md; do
        curlang=${link#*/}
        curlang=${curlang#*/}
        curlang=${curlang%%/*}
        linkname=${link##*/}
        linkname=${linkname%%\.*}
        filere="($linkname):\s{0,1}(.*?)"
        langre="($curlang):\s{0,1}(.*?)"

        while IFS="" read -r line || [ -n "$line" ]; do
            if [[ $line =~ $filere ]]; then
                newfile=${BASH_REMATCH[2]}
            fi
            if [[ $line =~ $langre ]]; then
                newlang=${BASH_REMATCH[2]}
            fi
        done < i18n/titles/$curlang/titles.yaml

        if [[ $curlang == $lang ]]; then
            sed -i '3s@$@'"$dir**$newlang** | "'@' $file
        else
            sed -i '3s@$@'"$dir[$newlang](/docs/$curlang$postlang/$newfile.md) | "'@' $file
        fi
    done
    sed -i '3s@$@'"$dir[[+]](https://librescore.ddns.net/projects/librescore/docs)\\n"'@' $file
    # sed -i '3s@$@'"$dir[![Translation status](https://librescore.ddns.net/widgets/librescore/-/docs/svg-badge.svg)](https://librescore.ddns.net/engage/librescore)\\n"'@' $file
done

shopt -u globstar

for file in i18n/titles/*/titles.yaml; do
    re="(.*?):\s{0,1}(.*?)"
    lang=${file%/*}
    lang=${lang##*/}
    while IFS="" read -r line || [ -n "$line" ]; do
        if [[ $line =~ $re ]]; then
            if [ "${BASH_REMATCH[1]}" != "${BASH_REMATCH[2]}" ]; then
                find ./i18n/*/$lang/ -name "${BASH_REMATCH[1]}.md" -exec sh -c 'mv $0 "${0%/*}/'"${BASH_REMATCH[2]}"'.md"' {} \;
            fi
        fi
    done < $file
done

shopt -u nullglob

exit 0
