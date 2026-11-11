# frozen_string_literal: true

# Run from the Baklib application: bundle exec rspec themes/cms/www/spec/tag_groups_spec.rb
require File.join(ENV.fetch("BAKLIB_ROOT") { File.expand_path("../../../..", __dir__) }, "spec/rails_helper")

RSpec.describe "WWW grouped tags" do
  include_context "with site context organization"

  let(:theme_root) { Pathname.new(__dir__).parent }
  let(:file_system) { ThemeEngine::Liquid::FileSystems::LocalFileSystem.new(theme_root) }
  let(:group) { TagGroup.create!(organization:, scope: site.to_tag_scope, key: "topics", name: "产品 & 服务 Product and Services / 企业内容管理与品牌知识运营分类") }
  let(:parent) { Tag.create!(organization:, scope: site.to_tag_scope, tag_group: group, key: "product", name: "产品分类") }
  let(:child) { Tag.create!(organization:, scope: site.to_tag_scope, tag_group: group, parent:, key: "cms", name: "CMS <企业版> EnterpriseContentAndKnowledgeManagementPlatform") }
  let(:legacy) { Tag.create!(organization:, scope: site.to_tag_scope, name: "旧标签") }
  let(:guest) { AccessControl::UserInfo.guest(site:) }
  let(:view_context) do
    controller = Portal::Site::TagsController.new
    controller.request = ActionDispatch::TestRequest.create
    controller.view_context
  end

  before do
    text = create(:theme_text, theme: site.theme, body: '[{"name":"theme_info","theme_name":"www","theme_scope":"cms"}]')
    Theme::VersionedFiles::Json.create!(theme_version: site.theme_version, path: "config/settings_schema.json", oid: text.oid)
  end

  %w[page page.side page.video].each do |name|
    it "keeps grouped and legacy selections valid in #{name}" do
      template = create(:theme_template, theme_version: site.theme_version, path: "templates/#{name}.liquid", body: theme_root.join("templates/#{name}.liquid").read)
      field = template.settings.find { |setting| setting["id"] == "tags" }
      expect(field).to include("type" => "tag_picker", "multiple" => true, "queryable" => true, "to_markdown" => true)
      expect(Tags::Selection.resolve!(consumer: site, raw_values: [child.iid, legacy.iid], id_kind: :iid, field:)).to eq([child, legacy])
      expect(Tags::Selection.resolve!(consumer: site, raw_values: nil, id_kind: :iid, field:)).to eq([])
    end
  end

  it "renders groups by stable key, ancestry, and legacy tags without duplicate escaping" do
    other_group = TagGroup.create!(organization:, scope: site.to_tag_scope, key: "audience", name: "适用对象 Audience / 企业客户与内容运营团队")
    other_tag = Tag.create!(organization:, scope: site.to_tag_scope, tag_group: other_group, name: "管理员")
    html = render_source("{% render 'tag_groups', tags: tags %}", "tags" => [drop(child), drop(legacy), drop(other_tag)])
    document = Nokogiri::HTML5.fragment(html)

    expect(document.css("[data-tag-group]").map { |node| node["data-tag-group"] }).to eq(["topics", "", "audience"])
    expect(document.css('[data-tag-group="topics"]').text).to include("产品 & 服务", "产品分类", "CMS <企业版>")
    expect(document.css('[data-tag-group=""]').text).to include("其他标签", "旧标签")
    expect(document.css("a[rel=tag]").size).to eq(3)
    expect(document.css("企业版")).to be_empty
    expect(html).not_to include("hsl(#", "&amp;lt;", "&amp;amp;")
    write_preview("grouped-tags", %(<main class="mx-auto max-w-6xl px-4 py-8">#{html}</main>))
  end

  it "omits the tag navigation when no tags are selected" do
    html = render_source("{% render 'tag_groups', tags: tags %}", "tags" => [])
    expect(Nokogiri::HTML5.fragment(html).css("nav")).to be_empty
  end

  it "indexes the compatible tags field for explicit descendant queries" do
    template = create(:theme_template, theme_version: site.theme_version, path: "templates/page.liquid", body: theme_root.join("templates/page.liquid").read)
    page = publish_page(template:, slug: "grouped-child", name: "Grouped child")
    page.templated_page.update!(template_variables: { "tags" => child.iid.to_s })
    pages = PagesDrop.new(site.pages.in_frontend.accessible(guest))
    html = render_source(<<~LIQUID, "source_pages" => pages)
      {% query exact from source_pages %}
      { "where": { "settings.tags_array_cont_any": ["#{parent.name}"] } }
      {% endquery %}
      exact:{% for item in exact %}{{ item.link_text }}{% endfor %};
      {% query expanded from source_pages %}
      { "include_descendants": true, "where": { "settings.tags_array_cont_any": ["#{parent.name}"] } }
      {% endquery %}
      expanded:{% for item in expanded %}{{ item.link_text }}{% endfor %};
    LIQUID

    expect(html).to include("exact:;", "expanded:Grouped child;")
  end

  it "keeps tag pages exact until descendant listing is explicitly enabled" do
    template = create(:theme_template, theme_version: site.theme_version, path: "templates/page.liquid", body: theme_root.join("templates/page.liquid").read)
    direct_page = publish_page(template:, slug: "direct", name: "Direct match")
    direct_page.templated_page.update!(template_variables: { "tags" => parent.iid.to_s })
    child_page = publish_page(template:, slug: "child", name: "Child match")
    child_page.templated_page.update!(template_variables: { "tags" => child.iid.to_s })
    hidden_page = publish_page(template:, slug: "hidden", name: "Hidden match")
    hidden_page.templated_page.update!(template_variables: { "tags" => child.iid.to_s })
    hidden_page.update!(hidden_from_list: true)
    source = theme_root.join("templates/tag.liquid").read
    allow(file_system).to receive(:read_template_file).and_call_original
    allow(file_system).to receive(:read_template_file).with("sidebar").and_return("")

    exact = render_source(source, "tag" => drop(parent), "params" => {})
    expect(exact).to include("Direct match", "?include_descendants=true")
    expect(exact).not_to include("Child match", "Hidden match")
    expect(Nokogiri::HTML5.fragment(exact).at_css('[aria-current="page"]').text).to eq("仅当前标签")

    expanded_drop = drop(parent)
    expanded_drop.list_descendant_pages!
    expanded = render_source(source, "tag" => expanded_drop, "params" => { "include_descendants" => "true" })
    expect(expanded).to include("Direct match", "Child match")
    expect(expanded).not_to include("Hidden match")
    expect(Nokogiri::HTML5.fragment(expanded).at_css('[aria-current="page"]').text).to eq("包含下级标签")
    write_preview("tag-exact", exact)
    write_preview("tag-expanded", expanded)
  end

  def drop(tag)
    Site::TagDrop.new(tag.decorated)
  end

  def publish_page(template:, slug:, name:)
    create(:page, site:, template:, slug:, name:).tap do |page|
      page.update_columns(full_path: "/#{slug}", calculated_link_text: name) # rubocop:disable Rails/SkipsModelValidations
      page.recording.update!(published: true, published_at: 1.day.ago, organization:, created_by: member, edited_by: member)
    end
  end

  def render_source(source, variables)
    registers = { file_system:, view_context:, current_site: site, current_user: guest, locale: :"zh-CN" }
    filters = [ThemeEngine::Liquid::Filters::LocalizationFilter, ThemeEngine::Liquid::Filters::AssetUrlFilter, ThemeEngine::Liquid::Filters::TypeofFilter]
    Liquid::Template.with_thread_safe do
      parser = ThemeEngine::Liquid::Parsers::TemplateParser.new.parse(source)
      context = Liquid::Context.new(variables, {}, registers)
      result = parser.render(context, filters:, strict_filters: true)
      expect(parser.liquid_template.errors).to be_empty, -> { parser.liquid_template.errors.map { |error| cause = error.cause || error; "#{cause.class}: #{cause.message}\n#{cause.backtrace.first(5).join("\n")}" }.join("\n") }
      result
    end
  end

  # Optional browser fixtures use the real compiled CSS and real transactional test records.
  # Standalone asset URLs and the two scope links are remapped to files after rendering.
  def write_preview(name, html)
    return unless ENV["WWW_TAG_PREVIEW_DIR"].present?

    output = Pathname.new(ENV.fetch("WWW_TAG_PREVIEW_DIR"))
    FileUtils.mkdir_p(output)
    FileUtils.cp(theme_root.join("assets/stylesheets/application.css"), output.join("application.css"))
    FileUtils.cp(theme_root.join("assets/images/img-min/bg-planet.jpg"), output.join("cover.jpg"))
    colors = file_system.theme_settings_schema.find { |setting| setting["name"] == "theme_info" }.dig("recommendations", "color_schemas", "baklib", "colors")
    color_css = ThemeEngine::ColorVariable.to_css(colors.map { |key, value| ThemeEngine::ColorVariable.new(key, value) })
    runtime_colors = render_source("{% render 'theme_runtime_colors' %}", {})
    document = Nokogiri::HTML5.fragment(html)
    document.css("img").each { |node| node["src"] = "cover.jpg" }
    document.css('nav[aria-label="标签内容范围"] a').each do |node|
      node["href"] = node["href"].include?("include_descendants=true") ? "tag-expanded.html" : "tag-exact.html"
    end
    output.join("#{name}.html").write(<<~HTML)
      <!doctype html><html lang="zh-CN"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
      <title>WWW #{name}</title><style>:root {#{color_css}}</style>#{runtime_colors}<link rel="stylesheet" href="application.css"></head>
      <body class="bg-base-100 text-base-content">#{document.to_html}</body></html>
    HTML
  end
end
