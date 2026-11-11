# 栏目与内页版式参考

以下 statics 页面用于查看布局。实际栏目和正文类型见[网站结构](../../structure.md)。

| 客户要的页面 | 参考 | 怎么用 |
| --- | --- | --- |
| 公司介绍 | `statics/about.liquid` | 页头是居中标题。正文用 `content` 3 或 4，能力用 `features` 2 或 `process` 1，人物用 `team` 2，结尾用 `cta` 4 |
| 服务或产品栏目 | `statics/services.liquid` | 栏目页头加一组 `services`。服务条目多、要扫读时用 `channel.list`；要配图卡片时用 `channel` |
| 作品或案例栏目 | `statics/portfolio.liquid` | 分类作品可选 portfolio1（有间距）或 portfolio2（紧排），代表作轮播用 portfolio3。客户只要栏目架构时可保留空栏目 |
| 价格 | `statics/pricing.liquid` | 按月订阅用 `pricing` 1，一次性报价用 `pricing` 2。价格不是客户给出的就不要做价格页 |
| 联系 | `statics/contact.liquid` | 居中表单构图用 contact3，地图加表单用 contact1 或 contact2；三种都需要另行绑定有效的业务接口 |
| 常见问题 | `statics/fax.liquid` | 折叠问答用 fax1，常显双列用 fax2 |
| 招聘 | `statics/career.liquid` | 福利用 `features` 2 或 `content` 5。职位列表的构图可参考 `snippets/components/_others1.liquid` |
| 新闻或文章栏目，偏浏览封面 | `statics/category.liquid` | 两列配图卡片，对应 `blogs` 1 或 4，栏目模板用 `channel` |
| 新闻或文章栏目，偏扫标题 | `statics/category-list.liquid` | 左图右文通栏，对应 `blogs` 2，栏目模板用 `channel.list` |
| 文章详情，旁边要相关内容 | `statics/single-post.liquid` | 正文走 `page.side`。相关文章、作者和评论是版式，没有真实数据就不要造 |
| 文章详情，阅读优先 | `statics/full-width-post.liquid` | 正文走 `page`，图可以比正文栏更宽 |
| 作者聚合 | `statics/author.liquid` | 只有客户明确要按作者归档时才做 |
| 搜索结果 | `statics/search.liquid` | 沿用站点搜索，不另做一套结果页 |
| 网站地图 | `statics/sitemap.liquid` | 列出真实页面，适合内容多、需要目录的站 |
| 尚未开放 | `statics/coming-soon.liquid` | 只在客户明确要求预告页时使用 |
| 找不到页面 | `statics/404.liquid` | 保留为系统页，不做成营销栏目 |
| 登录、注册、找回密码 | `statics/user-login.liquid`、`user-register.liquid`、`user-forgot.liquid` | 官网默认不用 |
| 配色 | `statics/brand.liquid` | 这不是页面。它是一套浅暖底、青绿主色、橙色辅色的语义色，整站换色时整组使用 |
