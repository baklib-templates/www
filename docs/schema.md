# 字段与 AI 写入边界

默认新站使用 index.sections；已有站点以固定版本的实际首页为准。真实类型、枚举和父子关系来自源码 Schema，manifest 只能进一步收窄权限。下面区分后台字段与 AI 写入白名单：Schema 中存在字段，不代表通用内容计划能写。

新版首页的 Schema 声明 `settings: []`。首页当前由独立 Liquid 片段渲染，组件选型见[组件目录](skill/references/components.md)。普通文章字段、全站设置和菜单分别使用各自的写入接口。媒体引用须来自当前站点有权使用的资源，标签通过授权选择器引用已有 IID。

## 全站

| id | 类型 | AI 内容写入 |
| --- | --- | --- |
| `logo_url` | image_picker | 白名单允许，仍需类型与来源校验 |
| `footer_logo_url` | image_picker | 白名单允许，仍需类型与来源校验 |
| `slogan` | text | 白名单允许，仍需类型与来源校验 |
| `request_title` | text | 白名单允许，仍需类型与来源校验 |
| `request_url` | text | 白名单允许，仍需类型与来源校验 |
| `is_show_author` | checkbox | 白名单允许，仍需类型与来源校验 |
| `default_avatar_url` | image_picker | 白名单允许，仍需类型与来源校验 |
| `default_thumb_url` | image_picker | 白名单允许，仍需类型与来源校验 |
| `lucide_icons` | textarea | 白名单允许，仍需类型与来源校验 |
| `cta_title` | html | 不在当前 manifest 白名单 |
| `brand_logos_on` | checkbox | 白名单允许，仍需类型与来源校验 |
| `brand_logos` | textarea | 白名单允许，仍需类型与来源校验 |
| `aside_html` | html | 不在当前 manifest 白名单 |
| `head_html` | html | 不在当前 manifest 白名单 |
| `header_menu` | textarea | 白名单允许，仍需类型与来源校验 |
| `footer_menu` | textarea | 白名单允许，仍需类型与来源校验 |
| `company_info` | html | 不在当前 manifest 白名单 |
| `copyright_info` | html | 不在当前 manifest 白名单 |
| `weixin_app_id` | text | 不在当前 manifest 白名单 |
| `weixin_app_secret` | text | 不在当前 manifest 白名单 |
| `weixin_enabled` | checkbox | 不在当前 manifest 白名单 |
| `weixin_debug` | checkbox | 不在当前 manifest 白名单 |

header_menu 一行一个“名称[/路径”；footer_menu 支持“分组[/路径{子项[/路径|子项[/路径”。两者都是 textarea，不是自动查询栏目。微信密钥只在受控后台配置，不作为模型上下文或页面文案。

## 默认首页 `index.sections`

此模板声明的页面设置为空，对应 manifest 的 `writable: []`。首屏及后续组件的数量、排列、标题、图片、按钮由本站的 Liquid 源码表达。源码可以读取实际栏目及其已发布子页。调整首页文案时，先定位实际引用的片段或本站已展开的区块。已有站点如使用带 `hero_*` 和 `section_N_*` 字段的旧模板，继续按其固定版本 Schema 编辑。

## 频道 `channel` / `channel.list` / `channel.side` / `channel.videos`

| id | 类型 | 用途 |
| --- | --- | --- |
| `title` | text | 栏目标题 |
| `description` | textarea | 栏目摘要，不替代文章正文 |
| `thumb_image_url` | image_picker | 栏目封面 |

## 正文 `page` / `page.side` / `page.video`

| id | 类型 | 用在 | 约束与用途 |
| --- | --- | --- | --- |
| `title` | text | 全部 | 可写正文标题 |
| `description` | textarea | 全部 | 摘要 |
| `content` | richtext | 全部 | 由正文服务写入，允许有来源的摘要/改写/翻译 |
| `tags` | tag_picker | 全部 | multiple/queryable；授权选择器按组与层级选择，保留旧 IID |
| `thumb_image_url` | image_picker | 全部 | 封面 |
| `icon` | select | 仅 `page` | 选项依赖 site.settings.lucide_icons |
| `youtube_id` | text | 仅 `page.video` | YouTube 标识 |
| `video_url` | video_picker | 仅 `page.video` | 已授权视频 |

标签组使用 tag_group 的稳定键，子树使用同一组的 tag_root 稳定键；无组约束的 tags 字段接受站点内已有分组、层级及未分组标签。模板种子不自动建词表；没有目标组时不能直接加硬编码组约束。标签页默认精确匹配，用户显式开启 include_descendants 才纳入下级。

## 其他首页变体

这些是已存在页面的可选样式，不替代新站默认 index.sections。实际字段如下；HTML 类型的 title/html_content 不在当前 AI 内容写入白名单。index.web-design 的两个 slider 标题同样是 HTML。

### `index`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `cta_title` | html |
| `hero_image_url` | image_picker |

### `index.advertising`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.branding`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.creative`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.digital`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.graphic`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.marketing`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `cta_title` | text |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.mobile-app`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.rtl`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.seo`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.social-media`

| id | 类型 |
| --- | --- |
| `title` | html |
| `description` | textarea |
| `hero_image_url` | image_picker |
| `html_content` | html |

### `index.web-design`

两幅轮播实际读取各自的标题、链接、图片，指标读取 counter_lines。section_image_url 和 html_content 虽有 Schema 声明，当前变体正文未读取这两个值。

| id | 类型 |
| --- | --- |
| `counter_lines` | textarea |
| `slider_one_title` | html |
| `slider_one_url` | text |
| `slider_one_image_url` | image_picker |
| `slider_two_title` | html |
| `slider_two_url` | text |
| `slider_two_image_url` | image_picker |
| `section_image_url` | image_picker |
| `html_content` | html |

