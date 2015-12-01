
class MarkdownIds < Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
    app.after_render do |content, path, locals, template_class|
      if Middleman::Renderers::ERb::Template && locals.has_key?(:toc_prefix)
        #doc = Nokogiri::HTML(content)
        #doc.css('[id]').each do |el|
          #el[:id] = "#{locals[:toc_prefix]}_#{el[:id]}"
        #end
        #content = doc.to_s
        content = MarkdownIds.add_prefix content, locals[:toc_prefix]
      end
      content
    end
  end


  def self.add_prefix(content, prefix)
    doc = Nokogiri::HTML(content)
    doc.css('[id]').each do |el|
      el[:id] = "#{prefix}_#{el[:id]}"
    end
    doc.to_s
  end

  def self.change_id(content, prefix)
    doc = Nokogiri::HTML(content)
    doc.css('[href]').each do |el|
      el[:href] = "##{prefix}_#{el[:href][1..-1]}"
    end
    doc.to_s
  end


end
