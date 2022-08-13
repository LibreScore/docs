<div dir="ltr" align="left">

&#8206;[العربية](/docs/ar/اقرأني.md) | &#8206;[English](/docs/en/README.md) | &#8206;[español](/docs/es/LÉAME.md) | &#8206;[français](/docs/fr/LISEZMOI.md) | &#8206;**magyar** | &#8206;[Melayu](/docs/ms/BACASAYA.md) | &#8206;[[+]](https://librescore.ddns.net/projects/librescore/docs)

[//]: # "\+\_==!|!=_=!|!==_/+/ ***NE MÓDOSÍTS SEMMIT E SOR FELETT*** /+/^^+#|#+^+#|#+^^\+\"

# Webmscore PWA

A webmscore eszköz hivatalos kezelőfelülete: <https://librescore.github.io>

## Fejlesztés

Miután csináltál egy új projektet és telepítetted a függőségeket az `npm install` (vagy az `pnpm install` vagy `yarn`) paranccsal, indítsd el egy fejlesztői szervert:

```bash
npm run dev

# vagy indítsa el a szervert, és nyissa meg az alkalmazást egy új böngészőlapon
npm run dev -- --open
```

## Összeállítás

Mielőtt létrehozná az alkalmazás általános elérhetőségi kiadását, telepítsen egy [adaptert](https://kit.svelte.dev/docs#adapters) a célkörnyezethez. Utána:

```bash
npm run build
```

> Megtekintheti a most elkészített alkalmazás előnézetét az `npm run preview` segítségével, függetlenül attól, hogy telepített-e adaptert. Ezt _nem_ szabad arra használni, hogy általánosan elérhető állapotban jelenítse meg az alkalmazást.

</div>