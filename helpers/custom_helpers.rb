module CustomHelpers

  def current_page_title
    title = current_page.data.title
    "#{title} · Shortcut " if title
  end

  def info_box(options={}, &block)
    captured_html = capture_html(&block)

    css_class = %w[info-box].concat([*options[:class]]).join(' ')

    concat_content(
      div(class: css_class) do
        div(class: 'clearfix') do
          div captured_html, class: 'inner-wrapper'
        end
      end
    )
  end

  def modal_view(options={}, &block)

    default_opts = {
      tabindex: '-1', role: 'dialog', 'aria-hidden' => 'true',
      class: 'modal--show modal--centered', 'data-cssmodal-resize' => 'true'
    }
    options.reverse_merge! default_opts

    captured_html = capture_html(&block)

    concat_content(
      content_tag(:section, options) do
        div(class: 'modal-inner') do
          div(captured_html, class: 'modal-content')+
          link_to('×', '#!', class: 'dismiss-button')
        end +
        link_to('×', '#!', class: 'modal-close', title: 'Close this modal', 'data-close' => 'Close', 'data-dismiss' => 'modal')
      end
    )
  end

  def youtube_player options={}
    default_opts = {
      class: 'yt-api', width: '610', height: '343',
      frameborder: '0', allowfullscreen: true
    }
    options.reverse_merge! default_opts

    src = URI.parse options[:src]
    src.query = [src.query, 'enablejsapi=1', 'rel=0'].compact.join('&')
    src.scheme = nil # make sure scheme is not set
    options[:src] = src

    content_tag(:iframe, ' ', options)
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
      partial("img/inline_svgs/#{id}.svg") +
      "<!--<![endif]-->"
    end
  end

  def div(content = nil, options = nil, &block)
    content_tag(:div, content, options, &block)
  end

  def manager_host
    ENV['MANAGER_HOST'] || 'http://manager.shortcutmedia.com'
  end
end
