# WWW 企业官网模板文档

设计首页时，从[11 个行业首页拆解](skill/references/homepage-patterns.md)选择接近的业务场景，查看原页顺序和资料要求，再到[组件目录](skill/references/components.md)打开对应的 Liquid 源码。

| 要解决的问题 | 入口 |
| --- | --- |
| WWW 适合哪类站点 | [模板定位](overview.md) |
| 怎样根据访客与资料选择区块 | [模板技能](skill/SKILL.md) · [首页组装与检查](usage.md) |
| 首页、栏目、文章如何组织 | [网站结构](structure.md) · [栏目与内页版式](skill/references/interior-pages.md) |
| 页面有哪些字段，允许写哪些 | [字段说明](schema.md) · [机器可读清单](skill/manifest.yml) |
| 在已有站点修改一个区块 | [工作台维护](skill/references/workbench.md) |
| 查看模板导入和版本资料 | [建站知识](setup_knowledge.yml) · [原文导入](activation.yml) · [发布检查](skill/release.yml) |

`templates/index.sections.liquid` 是组装入口；11 个行业首页是可独立查看的整页实例。演示种子 `002_pages.yml` 使用其中的 `index.web-design`。之前关于自动建站的设想单独保存在[讨论记录](homepage-plan.md)。
