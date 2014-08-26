module CustomHelpers

  def info_box(id, options={}, &block)

    inner_html = capture_html(&block)

    html_class = %w[info-box-background-image clearfix]
      .concat([*options[:class]])
      .join(' ')

    concat_content(
      [
        div('&nbsp;', class: 'grid_1'),
        div(class: 'grid_10') do
          div(id: id, class: html_class) do
            div(class: 'info-box-desc') do
              div(inner_html, class: 'box-content')
            end
          end
        end,
        content_tag(:div, '&nbsp;', class: 'grid_1')
      ].join
    )
  end

  def div(content = nil, options = nil, &block)
    content_tag(:div, content, options, &block)
  end


end
