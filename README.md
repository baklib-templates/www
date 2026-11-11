# WWW Baklib CMS Template

[简体中文](README.zh-CN.md) | English

This is a company website. Pages live on the site: a home page, channel sections, then articles. Use it for brand sites and marketing portals. Do not use it for product documentation or a discussion community.

The content model is documented in Chinese under `docs/`. Read that before the build notes below. Sample site data stays in `seeds/`; the get-started recipe is `docs/activation.yml`.

| File | Read it to learn |
| --- | --- |
| [docs/README.md](docs/README.md) | Index of the docs |
| [docs/overview.md](docs/overview.md) | What it is, and when to use it |
| [docs/structure.md](docs/structure.md) | Home, channels, and articles |
| [docs/schema.md](docs/schema.md) | Field ids, and which ones are writable |
| [docs/usage.md](docs/usage.md) | How to set the site up |
| [docs/activation.yml](docs/activation.yml) | Get-started arrangement recipe |

Enterprise brand website template for CMS portals. Built with Tailwind CSS v4, daisyUI v5, Turbo + Stimulus, and Lucide icons.


## Project structure

```
.
├── config/settings_schema.json
├── layout/theme.liquid
├── snippets/_theme_runtime_colors.liquid
├── snippets/_icon.liquid
├── src/stylesheets/application.css
├── src/javascripts/lucide_icons.js
├── package.json
├── templates/
├── statics/
└── seeds/
```

## Install guide

- Template guide: [https://help.baklib.cn/themes/www](https://help.baklib.cn/themes/www)
- Baklib theme development: [https://dev.baklib.cn/guide/git](https://dev.baklib.cn/guide/git)

## Build

```bash
git clone git@github.com:baklib-templates/www.git
```

