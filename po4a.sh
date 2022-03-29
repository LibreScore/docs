#!/bin/bash

/bin/echo "[po_directory] po
[options] -M UTF-8 -L UTF-8 -A UTF-8 --master-language en --msgmerge-opt '--no-wrap' --porefs file --wrap-po no
[po4a_alias:markdown] text -o markdown -o neverwrap -o nobullets" > "./po4a.conf"

shopt -s nullglob

for file in source/*/*.md; do
    folder=${file%/*}
    /bin/echo "[type:markdown] $file \$lang:i18n/${folder##*/}/\$lang/${file##*/}" >> "./po4a.conf"
done

for file in source/*/README.md; do
    folder=${file%/*}
    cp $file $folder/README_en.md
    /bin/echo "[type:markdown] $folder/README_en.md en:i18n/${folder##*/}/en/${file##*/} opt:\"-k 0\"" >> "./po4a.conf"
done

for file in source/*/*.yaml; do
    folder=${file%/*}
    /bin/echo "[type:yaml] $file \$lang:i18n/${folder##*/}/\$lang/${file##*/} opt:\"-k 0\"" >> "./po4a.conf"
done

shopt -u nullglob

/usr/local/bin/po4a ./po4a.conf -f -v

for file in source/*/README_en.md; do
    folder=${file%/*}
    rm $file
done

sed -i '/README_en.md/d' ./po4a.conf
sed -i '1d' ./i18n/*/*/*.yaml

exit 0
