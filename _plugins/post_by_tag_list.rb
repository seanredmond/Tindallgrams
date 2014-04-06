require 'date'

module Jekyll
  class TagLister < Liquid::Tag
    def make_id(tag)
      ['tag', tag.gsub(/\s/, '-').downcase].join('-')
    end
  end

  class TagListTag < TagLister
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
        output += "<dt id=\"#{make_id(tag)}\">#{tag}</dt>"
        output += "<dd>#{tags[tag].join(', ')}</dd>"
      end

      output += "</dl>"
    end
  end
end

module Jekyll
  class PageTagsTag < TagLister
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      tags = context.environments.first["page"]['tags']

      if tags == nil
        return
      end

      output = "<ul class=\"topics\">"
      tags.sort.each do |tag|
        output += %Q|
<li class="tags">
  <a href="/tags\##{make_id(tag)}">#{tag}</a>
</li>|
      end

      output += "</li></ul>"


      return output
    end
  end
end

Liquid::Template.register_tag('postsbytag', Jekyll::TagListTag)
Liquid::Template.register_tag('pagetags', Jekyll::PageTagsTag)
