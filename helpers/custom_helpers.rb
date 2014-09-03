module CustomHelpers

  def info_box(options={}, &block)

    inner_html = capture_html(&block)

    html_class = %w[grid-whole info-box-2]
      .concat([*options[:class]])
      .join(' ')

    concat_content(

      content_tag(:section, class: 'grid-whole info-box-wrapper') do
        div(class: 'l-grid-10 l-offset-1 m-grid-10 m-offset-1 s-grid-whole') do
          div(class: html_class) do
            [
              content_tag(:aside, class: "grid-all s-grid-whole") do
                content_tag(:figure) do
                  partial(options[:image_url])
                end
              end,
              content_tag(:article, inner_html, class: 'grid-all s-grid-whole invisible-hight-helper'),
              content_tag(:article, inner_html, class: 's-grid-whole visible')
            ].join
          end
        end
      end
    )
  end

  def div(content = nil, options = nil, &block)
    content_tag(:div, content, options, &block)
  end


end
