module CustomHelpers

  def current_page_title
    title = current_page.data.title
    "#{title} · Shortcut " if title
  end

  def info_box_flex(options={}, &block)
    captured_html = capture_html(&block)

    css_class = %w[info-box-3 flexbox]
      .concat([*options[:class]])
      .join(' ')

    concat_content(
      div(class: css_class) do
        div(class: 'clearfix') do
          div captured_html, class: 'inner-wrapper'
        end
      end
    )
  end

  def figure id, opt={}
    # The IE conditional comment is needed because of IE8. Although
    # IE8 is supposed to ignore the svg tag it somehow messes up the
    # rendering of the entire page if the svg tag contains the svg
    # namespace declaration (which could be theoretically removed from
    # the svg files but this is cumbersome).
    #
    content_tag(:figure, id: id, class: opt[:class]) do
      "\<!--[if gte IE 9]>\<!-->" +
      partial("img/#{id}.svg") +
      "<!--<![endif]-->"
    end
  end

  def div(content = nil, options = nil, &block)
    content_tag(:div, content, options, &block)
  end
end
