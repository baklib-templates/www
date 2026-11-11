# frozen_string_literal: true

require File.join(ENV.fetch("BAKLIB_ROOT") { File.expand_path("../../../..", __dir__) }, "spec/rails_helper")

RSpec.describe "WWW native homepage sections" do
  let(:root) { Pathname(__dir__).parent }
  let(:source) { root.join("templates/index.sections.liquid").read }
  let(:pages) do
    { "/case" => { "path" => "/case", "link_text" => "客户案例", "settings" => { "thumb_image_url" => "/case.jpg" } },
      "/news" => { "path" => "/news", "link_text" => "新闻", "children_in_list" => [], "settings" => {} } }
  end

  it "offers the same types for each independently editable slot, defaulting to off" do
    settings = JSON.parse(source.match(/{% schema %}(.*){% endschema %}/m)[1]).fetch("settings").index_by { _1["id"] }
    (1..6).each do |index|
      field = settings.fetch("section_#{index}_type")
      expect(field.fetch("default")).to eq("off")
      expect(field.fetch("choices").pluck("value")).to match_array(%w[off html latest cards feature spotlight cta])
      expect(settings.keys).to include(*%w[title description channel limit].map { "section_#{index}_#{_1}" })
    end
  end

  it "renders populated slots in order with optional destinations and no placeholder CTA" do
    doc = render_home(
      "section_1_type" => { "value" => "spotlight" }, "section_1_title" => "项目 & 品牌", "section_1_channel" => "/case",
      "section_2_type" => "off", "section_2_title" => "旧内容",
      "section_3_type" => "feature", "section_3_description" => "第一段\n第二段", "section_3_channel" => "/missing",
      "section_4_type" => "cta", "section_4_title" => "预约合作", "section_4_channel" => "/case",
      "section_5_type" => "feature", "section_5_title" => "第二项服务",
      "section_6_type" => "html", "section_6_html" => "<p>保留原有内容</p>"
    )
    sections = doc.css("[data-section-type]")
    expect(sections.map { _1["data-section-type"] }).to eq(%w[spotlight feature cta feature html])
    expect(sections[0].at_css("h2").text).to eq("项目 & 品牌")
    expect(sections[0].at_css("img")["src"]).to eq("/case.jpg")
    expect(sections[1].css("br").length).to eq(1)
    expect(sections[1].css("a")).to be_empty
    expect(sections[2].at_css("a")["href"]).to eq("/case")
    expect(sections[4].text).to include("保留原有内容")
    expect(doc.text).not_to include("旧内容", "联系信息待补充")
  end

  it "shows the hero alone for off, empty native slots, empty or missing channel lists" do
    doc = render_home("section_1_type" => "spotlight", "section_2_type" => "cta", "section_3_type" => "off",
                      "section_4_type" => "cards", "section_4_channel" => "/news",
                      "section_5_type" => "latest", "section_5_channel" => "/news",
                      "section_6_type" => "cards", "section_6_channel" => "/missing")
    expect(doc.at_css("h1").text).to eq("官网")
    expect(doc.css("section").length).to eq(1)
    expect(doc.css("a, img")).to be_empty
  end

  it "gives repeated CTA titles a distinct visible action while naming the destination for screen readers" do
    doc = render_home("section_1_type" => "cta", "section_1_title" => "客户案例", "section_1_channel" => "/case")
    link = doc.at_css("a")
    expect(link["href"]).to eq("/case")
    expect(link.text).to include("了解详情")
    expect(link.at_css(".sr-only").text).to include("客户案例")
  end

  it "leaves image stories full width and preserves the document order of adjacent text stories" do
    settings = (1..4).to_h { |index| ["section_#{index}_type", "spotlight"] }
    (1..4).each { |index| settings["section_#{index}_title"] = "案例 #{index}" }
    doc = render_home(settings.merge("section_4_channel" => "/case"))
    expect(doc.css(".wx-native--spotlight:not(.wx-native--media) h2").map(&:text)).to eq(["案例 1", "案例 2", "案例 3"])
    expect(doc.css(".wx-native--spotlight.wx-native--media h2").map(&:text)).to eq(["案例 4"])
  end

  it "shows both header actions only for a complete title and destination" do
    header = root.join("snippets/_header.liquid").read
    [{}, { "request_title" => "申请试用" }, { "request_title" => "  ", "request_url" => "/contact" }].each do |settings|
      doc = render_template(header, "site" => { "settings" => settings })
      expect(doc.css('a[target="_blank"]')).to be_empty
    end
    doc = render_template(header, "site" => { "settings" => { "request_title" => "申请试用", "request_url" => "/contact" } })
    expect(doc.css('a[href="/contact"]').map { _1.text.strip }).to eq(%w[申请试用 申请试用])
  end

  def render_home(settings)
    site = { "name" => "官网", "pages" => pages, "language" => "zh-CN", "settings" => { "cta_title" => "联系信息待补充" } }
    render_template(source, "page" => { "settings" => settings }, "site" => site)
  end

  def render_template(body, variables)
    filters = [ThemeEngine::Liquid::Filters::LimitFilter, ThemeEngine::Liquid::Filters::OrderByFilter, ThemeEngine::Liquid::Filters::LocalizationFilter]
    registers = { file_system: ThemeEngine::Liquid::FileSystems::LocalFileSystem.new(root), locale: :"zh-CN" }
    Liquid::Template.with_thread_safe do
      parser = ThemeEngine::Liquid::Parsers::TemplateParser.new.parse(body)
      html = parser.render(Liquid::Context.new(variables, {}, registers), filters:, strict_filters: true)
      expect(parser.liquid_template.errors).to be_empty
      Nokogiri::HTML5.fragment(html)
    end
  end
end
