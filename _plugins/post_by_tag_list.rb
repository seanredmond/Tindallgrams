require 'date'

module Jekyll
  class TagListTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      tgrams = context.registers[:site].pages.reject{|p| p.data['layout'] != 'tindallgram'}.
        sort{|a, b| DateTime.strptime(a.data['date'], '%b %d %Y') <=> DateTime.strptime(b.data['date'], '%b %d %Y')}

      tags = {}

      output = '<ul>'

      tgrams.each do |tg|
        serial = tg.data['serial']
        link = tg.url.gsub(/\.html$/, '')
        if tg.data['tags'] != nil
          tg.data['tags'].each do |tag|
            if !tags.keys.include?(tag)
              tags[tag] = []
            end

            tags[tag] << %Q|<a href="#{link}">#{serial}</a>|
          end
        end
      end

      output = "<dl>"

      tag_entries = tags.keys.sort

      tag_entries.each do |tag|
        output += "<dt>#{tag}</dt>"
        output += "<dd>#{tags[tag].join(', ')}</dd>"
      end

      output += "</dl>"
    end
  end
end

Liquid::Template.register_tag('postsbytag', Jekyll::TagListTag)
