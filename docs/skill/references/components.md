# WWW 首页组件目录

[组件源目录](../../../snippets/components/)收录 23 类、85 个 Liquid 文件。下表每个编号均链接到该变体源码。[组装入口](../../../templates/index.sections.liquid)列有全套调用示例，当前仅启用 `hero7`。例如 `{% render 'components/services3' %}` 对应 `_services3.liquid`。搭配顺序见[11 个首页实例](homepage-patterns.md)。

## 首屏、轮播与标题

| 用途 | 变体及选用依据 |
| --- | --- |
| 展示品牌或作品 | [hero1](../../../snippets/components/_hero1.liquid) 大幅产品预览与演示入口；[hero3](../../../snippets/components/_hero3.liquid) 品牌图像轮播；[hero4](../../../snippets/components/_hero4.liquid) 创意主张配服务和作品入口；[hero6](../../../snippets/components/_hero6.liquid) 背景大图突出作品风格。轮播需要一组可区分的画面。 |
| 说明业务主张 | [hero2](../../../snippets/components/_hero2.liquid) 广告诉求配背景图；[hero5](../../../snippets/components/_hero5.liquid) 综合服务与双入口；[hero9](../../../snippets/components/_hero9.liquid) 搜索优化服务配插图；[hero10](../../../snippets/components/_hero10.liquid) 社媒运营图文。将演示保证、地域和按钮换为本站事实。 |
| 展示产品或初始状态 | [hero8](../../../snippets/components/_hero8.liquid) 手机设备与应用画面，适合有真实界面时使用；[hero7](../../../snippets/components/_hero7.liquid) 半幅背景图与双按钮，源码标题为“网站已生成，正在准备内容中…”，正式首页需写入业务主张。 |
| 轮播 | [slider1](../../../snippets/components/_slider1.liquid) 两幅大图轮播，逐幅说明不同主张并设置落点；[slider2](../../../snippets/components/_slider2.liquid) 手机界面截图轮播，适合展示同一产品的不同操作。 |
| 标题 | [heading1](../../../snippets/components/_heading1.liquid) 搜索外观的页头，表单指向占位地址；[heading2](../../../snippets/components/_heading2.liquid) 面包屑与页面标题；[heading3](../../../snippets/components/_heading3.liquid) 作者资料；[heading4](../../../snippets/components/_heading4.liquid) 文章标题与分类路径；[heading5](../../../snippets/components/_heading5.liquid) 区块小标题。大多数用途在内页。 |

## 服务、方法与公司介绍

| 用途 | 变体及选用依据 |
| --- | --- |
| 服务范围 | [services1](../../../snippets/components/_services1.liquid) 投放服务图标卡；[services2](../../../snippets/components/_services2.liquid) 品牌识别与命名等短项；[services3](../../../snippets/components/_services3.liquid) 数字服务分类；[services4](../../../snippets/components/_services4.liquid) 设计门类。按访客能购买或询问的服务命名。 |
| 服务细分 | [services5](../../../snippets/components/_services5.liquid) 营销服务图文；[services6](../../../snippets/components/_services6.liquid) 应用开发服务；[services7](../../../snippets/components/_services7.liquid) SEO 项目；[services8](../../../snippets/components/_services8.liquid) 社媒运营项目。保留实际交付项目及目标链接。 |
| 公司和方法 | [content1](../../../snippets/components/_content1.liquid) 配图与编号方法；[content2](../../../snippets/components/_content2.liquid) 主张配简介；[content3](../../../snippets/components/_content3.liquid) 公司故事；[content4](../../../snippets/components/_content4.liquid) 能力概述与服务入口；[content5](../../../snippets/components/_content5.liquid) 加入团队。公司简介通常只需选其一。 |
| 功能和优势 | [features1](../../../snippets/components/_features1.liquid) 并列功能项；[features2](../../../snippets/components/_features2.liquid) 卡片式优势或福利；[features3](../../../snippets/components/_features3.liquid) 总述配分项说明。用功能描述能完成的任务，用优势解释选择理由。 |
| 工作步骤 | [process1](../../../snippets/components/_process1.liquid) 分栏编号说明，步骤有正文时用；[process2](../../../snippets/components/_process2.liquid) 横向短步骤，需改写示例中的地址、配送、支付等标签。 |

## 能力证据、作品与近期内容

| 用途 | 变体及选用依据 |
| --- | --- |
| 作品 | [portfolio1](../../../snippets/components/_portfolio1.liquid) 带间距的分类网格；[portfolio2](../../../snippets/components/_portfolio2.liquid) 紧排的分类网格，两者均能切换分类；[portfolio3](../../../snippets/components/_portfolio3.liquid) 项目轮播。源码自带示例作品、类别及图片，使用本站资料逐项替换。 |
| 文章 | [blogs1](../../../snippets/components/_blogs1.liquid) 三列阴影卡，最多 3 篇；[blogs2](../../../snippets/components/_blogs2.liquid) 横向图文，最多 4 篇；[blogs3](../../../snippets/components/_blogs3.liquid) 轮播，最多 5 篇；[blogs4](../../../snippets/components/_blogs4.liquid) 悬停放大的三列卡、[blogs5](../../../snippets/components/_blogs5.liquid) 叠层卡各最多 3 篇。五种均查询 `site.pages`，按 `template_name_eq: page` 筛选、`-published_at` 排序。特定新闻栏或案例栏需要明确栏目范围；无匹配文章时检查整段标题和留白。 |
| 标志与评价 | [brands1](../../../snippets/components/_brands1.liquid) 带导航的标志轮播；[brands2](../../../snippets/components/_brands2.liquid) 无导航按钮的轮播；[brands3](../../../snippets/components/_brands3.liquid) 静态标志行。[reviews1](../../../snippets/components/_reviews1.liquid) 带头像的评价卡；[reviews2](../../../snippets/components/_reviews2.liquid) 以引言为主的轮播。准备有授权的标志或可核对的引言、署名。 |
| 团队 | [team1](../../../snippets/components/_team1.liquid) 姓名与个人介绍大卡；[team2](../../../snippets/components/_team2.liquid) 带总述的人像网格；[team3](../../../snippets/components/_team3.liquid) 紧凑人像网格。没有公开成员资料时，用公司或服务介绍。 |
| 数据 | [counter1](../../../snippets/components/_counter1.liquid) 视差背景数字；[counter2](../../../snippets/components/_counter2.liquid) 图标配指标；[counter3](../../../snippets/components/_counter3.liquid) 经验年限与项目规模；[counter4](../../../snippets/components/_counter4.liquid) 分栏图标数字；[counter5](../../../snippets/components/_counter5.liquid) 紧凑的投放、曝光、点击和转化数字。记录指标名称、单位、统计范围与日期。 |
| 视频 | [video1](../../../snippets/components/_video1.liquid) 故事说明与播放入口；[video2](../../../snippets/components/_video2.liquid) 视频与分项卖点。两者源码都有演示视频链接，使用前替换并检查播放。 |

## 报价、行动入口与表单

| 用途 | 变体及选用依据 |
| --- | --- |
| 报价与问答 | [pricing1](../../../snippets/components/_pricing1.liquid) 月付与年付切换；[pricing2](../../../snippets/components/_pricing2.liquid) 一次性授权分档。[fax1](../../../snippets/components/_fax1.liquid) 单列折叠问答；[fax2](../../../snippets/components/_fax2.liquid) 双列常显问答。FAQ 的文件名前缀确为 `fax`。 |
| 行动邀请 | [cta1](../../../snippets/components/_cta1.liquid) 大背景加主按钮；[cta2](../../../snippets/components/_cta2.liquid) 横条左右分列；[cta3](../../../snippets/components/_cta3.liquid) 居中短句配按钮；[cta4](../../../snippets/components/_cta4.liquid) 邀请洽谈。中间两种示例的下载按钮实际指向 `#pricing`，采用时填写真实目的地。 |
| 应用下载与业务联系 | [download1](../../../snippets/components/_download1.liquid) 手机展示与商店按钮；[download2](../../../snippets/components/_download2.liquid) 背景图与商店按钮；[download3](../../../snippets/components/_download3.liquid) 业务咨询邀请。商店按钮要指向具体应用，咨询按钮要有真实联系入口。 |
| 联系 | [contact1](../../../snippets/components/_contact1.liquid) 左侧联系方式与地图、右侧表单；[contact2](../../../snippets/components/_contact2.liquid) 左表单、右地图和信息；[contact3](../../../snippets/components/_contact3.liquid) 居中单列表单。三种表单均为 `action="#"`。业务咨询需要接入能接收对应字段的接口，并验证成功与失败反馈。模板另有[页面反馈表单](../../../snippets/_feedback_form.liquid)，用途是收集页面反馈。 |
| 订阅 | [newsletter1](../../../snippets/components/_newsletter1.liquid) 邮箱订阅；[newsletter2](../../../snippets/components/_newsletter2.liquid) 横幅订阅；[newsletter3](../../../snippets/components/_newsletter3.liquid) 说明配表单。源码只提供表单外观，使用取决于有效的收集接口。 |

## 布局与专用片段

| 用途 | 变体及选用依据 |
| --- | --- |
| 导航 | [headers1](../../../snippets/components/_headers1.liquid)、[headers2](../../../snippets/components/_headers2.liquid)、[headers3](../../../snippets/components/_headers3.liquid)、[headers4](../../../snippets/components/_headers4.liquid)、[headers5](../../../snippets/components/_headers5.liquid) 均提供响应式演示导航，可比较品牌标识、菜单和移动端展开方式。本站常规导航由 layout 引入的 header 输出。 |
| 页脚 | [footers1](../../../snippets/components/_footers1.liquid) 多列信息与订阅；[footers2](../../../snippets/components/_footers2.liquid) 品牌与分组链接；[footers3](../../../snippets/components/_footers3.liquid) 简式版权与社交入口；[footers4](../../../snippets/components/_footers4.liquid) 版权与行内导航。整页通常沿用 layout 的页脚。 |
| 招聘 | [others1](../../../snippets/components/_others1.liquid) 职位空缺列表，适合有在招职位和真实详情入口的公司。 |

## 组装后的检查

同页重复使用同一类片段时检查 DOM id、锚点、表单标签和轮播控制目标，确保按钮作用于本区块。作品筛选、折叠 FAQ 和价格切换使用 Alpine 指令，轮播要有对应的 Swiper 初始化。用手机打开实际页面，分别操作筛选、下一张、展开与按钮，检查首屏文字可读、触控可用、空集合不留孤立标题。
