gem_group :development do
  gem 'bullet'
end

Bundler.with_unbundled_env { run 'bundle install' }
