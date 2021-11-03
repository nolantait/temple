gem 'dry-struct'

Bundler.with_unbundled_env { run 'bundle install' }

lib 'value.rb' do
  <<~TEMPLATE
    require 'dry-struct'

    class Value < Dry::Struct
    end
  TEMPLATE
end
