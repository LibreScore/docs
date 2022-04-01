<div dir="ltr" align="left">

[&#8206;العربية](/docs/ar/اقرأني.md) | [&#8206;English](/docs/en/README.md) | [&#8206;Español](/docs/es/LÉAME.md) | &#8206;**Français** | &#8206;[[+]](https://librescore.ddns.net/projects/librescore/docs)

[&#8206;العربية](/docs/ar/اقرأني.md) | &#8206;**English** | [&#8206;Español](/docs/es/LÉAME.md) | [&#8206;Français](/docs/fr/LISEZMOI.md) | &#8206;[[+]](https://librescore.ddns.net/projects/librescore/docs)

# Application Web progressive de Webmscore

<div align="center">

[![Discord](https://img.shields.io/discord/774491656643674122?color=5865F2&label=&labelColor=555555&logo=discord&logoColor=FFFFFF)](https://discord.gg/DKu7cUZ4XQ) [![Weblate](https://librescore.ddns.net/widgets/librescore/-/webmscore-pwa/svg-badge.svg)](https://librescore.ddns.net/engage/librescore)

L'interface officielle de l'outil webmscore : <https://librescore.github.io>

</div>

## Développement

Une fois que vous avez créé un projet et installé les dépendances avec `npm install` (ou `pnpm install` ou `yarn`), démarrez un serveur de développement :

```bash
npm run dev

# ou démarrez le serveur et ouvrez l'application dans un nouvel onglet du navigateur
npm run dev -- --open
```

## Construction

Avant de créer une version de production de votre application, installez un [adaptateur](https://kit.svelte.dev/docs#adapters) pour votre environnement cible. Puis :

```bash
npm run build
```

> Vous pouvez prévisualiser l'application construite avec `npm run preview`, que vous ayez installé un adaptateur ou non. Cela ne doit _pas_ être utilisé pour diffuser votre application en production.

</div>
