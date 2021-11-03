require_relative '../utils'

gem_group :development do
  gem 'brakeman'
end

Bundler.with_unbundled_env { run 'bundle install' }

create_bin 'brakeman'
