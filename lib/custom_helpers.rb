module CustomHelpers
  def figure(image_id, &block)
    captured_html = block_given? ? capture_html(&block) : ""
    concat_content(
      div(class: image_id) do
        content_tag :figure, captured_html, class: "fixed-ratio"
      end
    )
  end


  def div(content = nil, options = nil, &block)
    content_tag(:div, content, options, &block)
  end

  #def svg_image(file, klass=file, use_class="use_#{file}")
    #concat_content(
      #content_tag(:svg, {"xmlns:xlink" => 'http://www.w3.org/1999/xlink', class: klass}) do
        #content_tag :use, nil, {:class => use_class , "xlink:href" => "/images/sprite.svg##{file}"}
      #end
    #)
  #end

  #def svg_image(src, opt={})
    #opt = opt.merge!(use_class: "use_#{opt[:class]}")
    #concat_content(
      #content_tag(:svg, {"xmlns:xlink" => 'http://www.w3.org/1999/xlink', class: opt[:class]}) do
        #content_tag :use, nil, {:class => opt[:use_class], "xlink:href" => src }
      #end
    #)
  #end

  def svg_image_tag(src, opts={})
    src = URI.parse(src)
    src = URI.parse("/images/#{src}") unless src.host # prepand /images/ if relative src

    if src.fragment
      merge_attributes = -> key, old, new { "#{old} #{new}" }

      # use 'use'-tag to link to svg
      opts = opts.merge({class: src.fragment}, &merge_attributes) # defaults for opts
      opts = opts.merge("xmlns:xlink" => 'http://www.w3.org/1999/xlink')

      #concat_content(
        content_tag(:svg, opts) do
          content_tag :use, nil, {"xlink:href" => src }
        end
      #)
    else
    end
  end


  def figure src, opts={}
    src = URI.parse(src)

    if src.fragment
      klass = opts[:class] || "svg-#{src.fragment}"

      if opts.has_key? :fluid
        klass += ' fluid'
        fluid_options = opts.delete :fluid
        opts.merge!(viewBox: "#{([0, 0] + fluid_options).join(' ')}")

        #concat_content(
          content_tag(:figure, class: klass) do
            svg_image_tag src.to_s, opts
          end
        #)
      else
        raise "unsupported yet"
      end
    else
      raise "unsupported yet"
    end
  end

  #def table_of_contents(resource)
    #content = File.read(resource.source_file)
    #toc_renderer = Redcarpet::Render::HTML_TOC.new
    #markdown = Redcarpet::Markdown.new(toc_renderer, nesting_level: 2) # nesting_level is optional
    #markdown.render(content)
  #end

  def table_of_contents(source_file, toc_prefix=nil)
    file = File.expand_path("../../source/#{source_file}", __FILE__)
    content = File.read(file)
    toc_renderer = Redcarpet::Render::HTML_TOC.new nesting_level: 3
    markdown = Redcarpet::Markdown.new(toc_renderer)
    toc = markdown.render(content)

    if toc_prefix
      toc = MarkdownIds.change_id toc, toc_prefix
    end

    doc = Nokogiri::HTML(toc)
    doc.css('ul').each do |el|
      el[:class] = 'nav'
    end
    toc = doc.to_s
    toc
  end

  def deferred_image_tag path, options = {}
    data = options[:data] || options['data'] || {}
    options[:data] = data.merge 'deferred-image' => image_path(path)

    image_tag 'data:image/png;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=', options
  end

  def documentation_url path = ''
    @docs_base_url + path.sub(/^\//, '')
  end

  def manager_url path = ''
    @manager_base_url + path.sub(/^\//, '')
  end

  def blog_url path = ''
    @blog_base_url + path.sub(/^\//, '')
  end

end

