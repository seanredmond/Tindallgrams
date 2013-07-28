require "redcarpet"

module Jekyll
  class GlossaryPage < Page
    def initialize(site, base, dir, alpha, glosslist)
      @site = site
      @base = base
      @dir = dir
      @name = "#{alpha}.html"

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'glossary_page.html')

      self.data['title'] = "Glossary #{alpha}"
      glosslist = glosslist.keys.sort{|a, b| a.downcase <=> b.downcase}.map{|k| glosslist[k]}
      self.data['glosslist'] = glosslist
    end
  end

  class GlossaryPageGenerator < Generator
    def initialize(config)
      super
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
      glossfile = YAML.load_file('_data/glossary.yaml')['glossary']
      glossfile.each do |g|
        if g.key?('def')
          g['def'] = @markdown.render(g['def'])
        elsif g.key?('cf')
          g['def'] = @markdown.render("See #{g['cf']}")
        end
      end
      @glossary = Hash[glossfile.map{|g| [g['term'], g]}]

    end

    def generate(site)
      dir = 'terms'

      #First generate a page for all terms that don't begin with a letter
      by_letter = @glossary.reject{|k,v| k[0].downcase =~ /[a-z]/}
      site.pages << GlossaryPage.new(site, site.source, dir, 'non-alpha', by_letter)

      # Make a list of all the first characters of the glossary terms
      letters = @glossary.keys.map{|a| a[0].downcase}.uniq

      letters.reject{|l| l =~ /[^a-z]/}.each do |category|
        by_letter = @glossary.reject{|k,v| k[0].downcase != category}
        site.pages << GlossaryPage.new(site, site.source, dir, category, by_letter)
      end
    end
  end


  class GlossaryYamlTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      glossfile = YAML.load_file('_data/glossary.yaml')['glossary']
      @glossary = Hash[glossfile.map{|g| [g['term'], g]}]
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)

      super
    end
  end

  class GlossaryTag < GlossaryYamlTag
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

  class GlossaryAlphaTag < GlossaryYamlTag
    def initialize(tag_name, markup, tokens)
      super
      @alpha = @glossary.keys.map{|a| a[0].downcase}.uniq.
        reject{|a| a =~ /[^a-z]/}.sort
      @alpha << 'non-alpha'
    end

    def render(context)
      output = '<ul class="terms-alpha">'
      @alpha.each do |a|
        output += %Q|<li><a href="/terms/#{a}">#{a}</a></li>|
      end
      output += '</ul>'
    end
  end
end

Liquid::Template.register_tag('glossary', Jekyll::GlossaryTag)
Liquid::Template.register_tag('glossary_alpha', Jekyll::GlossaryAlphaTag)

