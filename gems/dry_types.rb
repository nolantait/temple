gem 'dry-types'

Bundler.with_unbundled_env { run 'bundle install' }

lib 'types.rb' do
  <<~TEMPLATE
    require "dry-types"

    module Types
      include Dry.Types()
    end
  TEMPLATE
end
