require "cgi"

module Jekyll
  class DdgSearchTag < Liquid::Tag
    safe = true
    priority = :low
 
    def initialize(tag_name, text, tokens)
      super
      @tag = tag_name
      @text = text
      @search_url = 'https://duckduckgo.com/search.html'
      # options that control output
      @tag_options = ['frameborder', 'buttontext']
      # see https://duckduckgo.com/search_box
      @simple_options = ['width', 'duck', 'site', 'prefill', 'bgcolor', 'focus']
      # see https://duckduckgo.com/params
      @advanced_options = [
        'kp', 'kl', 'ki', 'kz', 'kc', 'kn', 'kf', 'kb', 'kd', 'kg', 'kh', 'kj',
        'ky', 'kx', 'k7', 'k8', 'k9', 'kaa', 'kab', 'ks', 'kw', 'km', 'ka', 
        'ku', 'kt', 'k2', 'ko', 'k3', 'kk', 'ke', 'kr', 'kq', 'k1', 'kv', 'k4', 
        't', 'sites'
      ]
      @valid_options = @simple_options + @advanced_options + @tag_options
      @options = get_options(text)
      @frameborder = 
        escape_options('frameborder', @options.delete('frameborder'))
    end
 
    # Parse options from text string key:var pairs. Options with invalid keys 
    # or nil values are removed
    def get_options(opt_string)
      parsed_opts = fixup_options(
        Hash[opt_string.split(/\s+/).map{|opt| opt.split(':')}].
        delete_if{|k, v| (!@valid_options.include?(k)) || (v == nil) }
      )
    end

    # Handle options that need some special treatment
    def fixup_options(opts)
      # The iframe version uses the 'site' parameter, while the form version
      # uses 'sites'. Conver one to the other where necessary
      if @tag == 'ddg_search'
        if opts['site'] == nil && opts['sites'] != nil
          opts['site'] = opts.delete('sites')
        end
      else
        if opts['sites'] == nil && opts['site'] != nil
          opts['sites'] = opts.delete('site')
        end
      end

      return opts
    end


    # Escape query parameters, with special handling for prefill option
    #
    # Since prefill is a prompt phrase, it will probably require spaces. In the
    # tag, spaces need to be entered as '+' so the tag options can be split
    # correctly. Pluses are then escaped as '%2B' which are finally converted
    # back to spaces.
    #
    # It would be better if DuckDuckGo handled escaped spaces better in their
    # form generation.
    def escape_options(key, value)
      if value == nil
        return value
      end

      value = CGI::escape(value)
      if ['prefill', 'buttontext'].include?('prefill')
        value.gsub!('%2B', ' ')
      end

      return value
    end

    # Convert options to URL params
    def options_query(opts)
      opts.map{|k,v| "#{k}=#{escape_options(k, v)}"}.join('&amp;')
    end

    # Output iframe version of search box
    def render_iframe(context)
      url = [@search_url, options_query(@options)].join('?')
      border = ''
      if @frameborder != nil
        border = %Q| frameborder="#{@frameborder}"|
      end

      return %Q|<iframe src="#{url}"#{border}></iframe>|
    end

    # Generate hidden form inputs
    def hidden_inputs(opts)
      opts.reject{|k, v| !@advanced_options.include?(k)}.map{|k, v| 
        %Q|<input type="hidden" name="#{k}" value="#{v}"/>|
      }.join(' ')
    end

    # Generate search box form form version
    def search_input(opts)
      placeholder = ''
      if opts.has_key?('prefill')
        placeholder = 
          %Q| placeholder="#{escape_options('prefill',opts['prefill'])}"|
      end
      return %Q|<input type="text" name="q" maxlength="255"#{placeholder}/>|
    end

    # Generate text for submit button
    def search_button(opts)
      if opts['buttontext'] != nil
        return escape_options('buttontext', opts['buttontext'])
      end
      return 'Search'
    end

    # Generate form version of search box
    def render_form(context)
      inputs = 
<<HTML
<form method="get" id="search" action="http://duckduckgo.com/">
  #{hidden_inputs(@options)}
  #{search_input(@options)}
  <input type="submit" value="#{search_button(@options)}" />
  
</form>
HTML
    end

    def render(context)
      if @tag == 'ddg_search'
        render_iframe(context)
      else
        render_form(context)
      end
    end
  end
end
 
Liquid::Template.register_tag('ddg_search', Jekyll::DdgSearchTag)
Liquid::Template.register_tag('ddg_search_form', Jekyll::DdgSearchTag)
