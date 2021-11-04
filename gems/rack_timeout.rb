# Add rack timeout gem to production
gem_group :production do
  gem 'rack-timeout'
end

Bundler.with_unbundled_env { run 'bundle install' }

# Add rack timeout to sample env
append_file '.sample.env', 'RACK_TIMEOUT_SERVICE_TIMEOUT=10'
