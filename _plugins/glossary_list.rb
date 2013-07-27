require "redcarpet"

module Jekyll
  class GlossaryTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      glossfile = YAML.load_file('_data/glossary.yaml')['glossary']
      @glossary = Hash[glossfile.map{|g| [g['term'], g]}]
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)

      super
    end


    def matches(content)
      matches = @glossary.keys.map{|k| k if /\b#{k}\b/i =~ content}.reject{|g| g == nil}
      cfs = matches.map{|m| @glossary[m]['cf'] if @glossary[m]['cf'] != nil}.reject{|cf| cf == nil}
      if cfs.count > 0
        return (matches + cfs).uniq
      end
      return matches
    end

    def gloss_list(term)
      if @glossary[term].has_key?('def')
        return "<dt>#{term}</dt><dd>#{@markdown.render(@glossary[term]['def'])}</dd>"
      end

      if @glossary[term].has_key?('cf')
        cf = "see #{@glossary[term]['cf']}"
        return "<dt>#{term}</dt><dd>#{@markdown.render(cf)}</dd>"
      end
    end

    def render(context)
      content = context.environments.first['page']['content']
      terms = matches(content).map{|m| gloss_list(m)}.sort.join('')

      "<dl>#{terms}</dl>"

    end
  end
end

Liquid::Template.register_tag('glossary', Jekyll::GlossaryTag)

