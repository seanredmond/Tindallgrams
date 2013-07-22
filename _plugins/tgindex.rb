require 'date'

module Jekyll
  class TindallgramIndexTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      cfg = YAML.load_file('_data/tindallgrams-index.yaml')

      # Make hash index of published pages
      published = Hash[context.registers[:site].pages.
        reject{|p| p.data['layout'] != 'tindallgram'}.
        map{|p| [p.data['serial'], p]}]

      output = '<table class="tindallgram-index"><tbody>'
      cfg['tindallgrams'].each do |tg|
        if tg['date'] == nil
          datefmt = " "
        else 
          datefmt = tg['date'].strftime('%b %d %Y')
        end

        if published.keys.include?(tg['serial'])
          link = published[tg['serial']].url.gsub(/\.html$/, '')
          subject = %Q|<a href="#{link}">#{tg['subject']}</a>|
        else
          subject = tg['subject']
        end

        output += %Q|
<tr>
  <td class="serial">#{tg['serial']}</td>
  <td class="date">#{datefmt}</td>
  <td class="subject">#{subject}</td>
  <td class="sources">#{tg['sources'].join(', ')}</td>
</tr>|
      end

      output += '</tbody></table>'
      return output
    end
  end
end

Liquid::Template.register_tag('tgindex', Jekyll::TindallgramIndexTag)
