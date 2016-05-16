module FeatureButtons

  class FeatureButton

    def initialize attrs
      @id = attrs[:id]
      @icon = attrs[:icon]
      @text = attrs[:text]
    end

    def html context, classes = 'pill button'
      context.link_to "/features.html##{@id}", class: classes do
        html = context.svg_image_tag "sprite.svg##{@icon}"
        html += @text
      end
    end

  end


  @buttons = [
    { id: 'deep_linking',    icon: 'icon-f-deeplinking',    text: 'Deep Linking' },
    { id: 'app_banners',     icon: 'icon-f-appmarketing',   text: 'App Banners' },
    { id: 'beacons',         icon: 'icon-f-ibeacons',       text: 'iBeacons' },
    { id: 'newsletters',     icon: 'icon-f-newsletter',     text: 'Newsletters' },
    # { id: 'auto_messages',   icon: 'icon-f-automessages',   text: 'Auto Messages' },
    { id: 'social_media',    icon: 'icon-f-socialmedia',    text: 'Social Media' },
    { id: 'app_referrals',   icon: 'icon-f-appreferals',    text: 'App Referals' },
    { id: 'print',           icon: 'icon-f-print',          text: 'Print' },
    { id: 'analytics',       icon: 'icon-f-analyze',        text: 'Analytics' },
    { id: 'custom_landers',  icon: 'icon-f-customlanders',  text: 'Custom Landers' },
    { id: 'marketing_links', icon: 'icon-f-marketinglinks', text: 'Marketing Links' },
    { id: 'custom_domains',  icon: 'icon-f-customdomain',   text: 'Custom Domains' },
  ]


  def self.all
    @buttons.map{ |attrs| FeatureButton.new attrs }
  end

  def self.pick buttons
    buttons.map{ |id| FeatureButton.new @buttons.find{ |b| b[:id] == id } }
  end

end