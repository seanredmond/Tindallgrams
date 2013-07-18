Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require "bundler/setup"
Bundler.require(:default)

use Rack::Rewrite do
    rewrite %r{/(.+)}, lambda {     |match, rack_env| 
        if File.exists?('_site/' + match[1] + '.html')
            return '/' + match[1] + '.html' 
        else
            return '/' + match[1]
        end
    }
end

run Rack::Jekyll.new(:destination => '_site')