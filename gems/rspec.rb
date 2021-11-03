require 'utils'

gem_group :development, :test do
  gem 'rspec-rails'
end

Bundler.with_unbundled_env { run 'bundle install' }

generate 'rspec:install'

run 'rm -rf test'

create_bin 'rspec'
