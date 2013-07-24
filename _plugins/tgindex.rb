require 'date'

module Jekyll
  class TindallgramIndexTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @grams = YAML.load_file('_data/tindallgrams-index.yaml')['tindallgrams']
      @opts = markup.split(/\s+/)
      @filtered = filter(@grams, @opts[0], @opts[1])

    end

    def filter(grams, filter_type, filter_value)
      if filter_type == 'year'
        return grams.reject{|g| g['date'].strftime('%Y') != filter_value}
      elsif filter_type == 'source'
        return grams.reject{|g| !g['sources'].include?(filter_value.to_i)}
      end

      return grams
    end

    def render(context)
      published = Hash[context.registers[:site].pages.
        reject{|p| p.data['layout'] != 'tindallgram'}.
        map{|p| [p.data['serial'], p]}]

      # Make hash index of published pages

      output = %Q|
<table class="tindallgram-index">
  <thead>
    <th>Serial</th><th>Date</th><th>Subject</th><th>Sources</th>
  </thead>
  <tbody>|
  
      @filtered.each do |tg|
        if tg['date'] == nil
          datefmt = " "
        else 
          datefmt = tg['date'].strftime('%b %d %Y')
        end

        row_open_tag = '<tr>'
        if published.keys.include?(tg['serial'])
          row_open_tag = '<tr class="published">'
          link = published[tg['serial']].url.gsub(/\.html$/, '')
          subject = %Q|<a href="#{link}">#{tg['subject']}</a>|
        else
          subject = tg['subject']
        end

        output += %Q|
#{row_open_tag}
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
