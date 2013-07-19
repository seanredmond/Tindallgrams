module Jekyll
  class TindallGramListTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      tgrams = context.registers[:site].pages.reject{|p| p.data['layout'] != 'tindallgram'}.
        sort{|a, b| b.data['date'] <=> a.data['date']}

      output = '<table><tbody>'

      tgrams.each do |tg|
        date = tg.data['date']
        serial = tg.data['serial']
        subject = tg.data['subject']
        link = tg.url.gsub(/\.html$/, '')
        output += %Q|
<tr>
  <td>#{date}</td>
  <td>#{serial}</td>
  <td><a href="#{link}">#{subject}</a></td>
</tr>|
      end

      output += "</tr></tbody></table>"
    end
  end
end

Liquid::Template.register_tag('tgramlist', Jekyll::TindallGramListTag)
