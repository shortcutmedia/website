###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
#configure :development do
  #activate :livereload
#end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end
require "lib/custom_helpers"
helpers CustomHelpers

@base_url         = 'https://shortcut.sc/'
@blog_base_url    = 'http://blog.shortcut.sc/'
@docs_base_url    = 'http://developer.shortcut.sc/'
@manager_base_url = 'https://manager.shortcut.sc/'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :middleman_scavenger do |config|
  config.path = "source/images/svg/"
  config.sprite_path = "source/images/sprite.svg"
  #config.path = "source/images/benefits_svg/"
  #config.sprite_path = "source/images/benefits_sprite.svg"
end

# activate :deploy do |deploy|
#   deploy.method = :git
#   deploy.remote = 'https://shortcut-web@shortcut-website.scm.azurewebsites.net:443/shortcut-website.git'
#   deploy.branch = 'master'
#   deploy.build_before = true
# end


activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, with_toc_data: true


activate :alias

require "lib/markdown_ids"
::Middleman::Extensions.register(:markdown_ids, MarkdownIds)
activate :markdown_ids

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  #
  # ignore "source/images/customers/*"

end

activate :autoprefixer do |config|
  config.browsers = [ 'last 2 versions', 'Explorer >= 10' ]
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'website.shortcut.sc' # The name of the S3 bucket you are targeting. This is globally unique.
  s3_sync.region                     = 'eu-west-1'     # The AWS region for your bucket.
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end
