# 网站结构与执行边界

WWW 使用 CMS 站点页面作为内容源，不自动创建知识库。模板清单的首页是 `index.sections`，查看已有站点时以其实际采用的首页变体为准。

常用结构是首页 → 栏目 → 文章，并非固定三层：`channel` 可嵌套栏目，`page` 可继续承载文章子页。内容计划必须按固定版本 TemplateContract 展开的父子关系执行，不能凭模板名称猜层级。

## 页面关系

下表对应真实 sub_page_templates。未带样式的 page/channel 声明由平台展开到该类型的所有变体；带样式名称只对应一个变体。

| 模板 | 子页面 |
| --- | --- |
| `templates/index.sections.liquid` | `channel`、`channel.list`、`channel.side`、`channel.videos` |
| `templates/index.liquid` | `channel` |
| `templates/channel.liquid` | `page`、`channel` |
| `templates/channel.list.liquid` | `page` |
| `templates/channel.side.liquid` | `page.side` |
| `templates/channel.videos.liquid` | `page.video` |
| `templates/page.liquid` | `page` |
| `templates/page.side.liquid` | 无 |
| `templates/page.video.liquid` | 无 |

其余 index 变体的子页面声明均为 channel。普通正文优先 page，侧栏正文用 page.side，视频用 page.video；频道是聚合页，不把正文全部塞进频道摘要。

## 首页、导航与内容依赖

[组装首页](../templates/index.sections.liquid)当前只启用 hero7，其余组件调用列为注释。layout 提供页头、页脚。介绍、服务与工作方法可以直接来自企业资料；展示文章的组件需要实际页面和合适的查询范围。只建栏目架构时，可以在导航里提供栏目入口，在首页安排有资料的介绍、方法和行动按钮。见[首页选型](skill/references/homepage-patterns.md)。

页头页脚使用全站 header_menu 和 footer_menu 字段。新增栏目后应核对菜单中的真实页面路径。站内搜索路径为 `-/search`。

## 内容来源

栏目和文章存放在 CMS。原文导入的目录组织见[导入规则](activation.yml)。演示种子在 `seeds/`，其中 `002_pages.yml` 选择带轮播和指标设置的 index.web-design。演示名称、价格、指标与评价只能作为排版样例。
