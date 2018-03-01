require 'date'

module Jekyll
  class TindallGramListTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      tgrams = context.registers[:site].pages.reject{|p| p.data['layout'] != 'tindallgram'}.
        sort{|a, b| DateTime.strptime(a.data['date'], '%b %d %Y') <=> DateTime.strptime(b.data['date'], '%b %d %Y')}

      output = %Q|
<table class="tindallgram-index">
  <thead>
    <tr>
      <th scope="col">Date</th>
      <th scope="col">Serial Number</th>
      <th scope="col">Subject</th>
    </tr>
  </thead>
  <tbody>
   |

      tgrams.each do |tg|
        date = tg.data['date']
        serial = tg.data['serial']
        subject = tg.data['subject']
        link = tg.url.gsub(/\.html$/, '')
        output += %Q|
<tr>
  <td class="date">#{date}</td>
  <td class="serial">#{serial}</td>
  <td class="subject"><a href="#{link}">#{subject}</a></td>
</tr>|
      end

      output += "</tbody></table>"
    end
  end
end

Liquid::Template.register_tag('tgramlist', Jekyll::TindallGramListTag)
