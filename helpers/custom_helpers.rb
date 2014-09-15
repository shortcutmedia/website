module CustomHelpers

  def info_box_flex(options={}, &block)
    captured_html = capture_html(&block)

    #css_class = %w[info-box-3 flexbox]
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

  def info_box(options={}, &block)

    captured_html = capture_html(&block)

    inner_html = []

    inner_html_class = %w[grid-whole info-box-2]
      .concat([*options[:class]])
      .join(' ')


    unless options[:no_aside]
      inner_html << content_tag(:aside, class: "grid-all s-grid-whole") do
        content_tag(:figure) do
          partial(options[:image_url])
        end
      end

    end
    inner_html << content_tag(:article, captured_html, class: 'grid-all s-grid-whole invisible-hight-helper')

    inner_html << content_tag(:article, captured_html, class: 's-grid-whole visible')

    concat_content(

      content_tag(:section, class: 'grid-whole info-box-wrapper') do
        div(class: 'l-grid-10 l-offset-1 m-grid-10 m-offset-1 s-grid-whole') do
          div inner_html.join, class: inner_html_class
        end
      end
      #content_tag(:section, class: 'grid-whole info-box-wrapper') do
        #div(class: 'l-grid-10 l-offset-1 m-grid-10 m-offset-1 s-grid-whole') do
          #div(class: html_class) do
            #[
              #content_tag(:aside, class: "grid-all s-grid-whole") do
                #content_tag(:figure) do
                  #partial(options[:image_url])
                #end
              #end,
              #content_tag(:article, inner_html, class: 'grid-all s-grid-whole invisible-hight-helper'),
              #content_tag(:article, inner_html, class: 's-grid-whole visible')
            #].join
          #end
        #end
      #end

    )
  end

  def div(content = nil, options = nil, &block)
    content_tag(:div, content, options, &block)
  end


end
