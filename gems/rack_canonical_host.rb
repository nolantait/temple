# Add canonical host to production
gem_group :production do
  gem 'rack-canonical-host'
end

Bundler.with_unbundled_env { run 'bundle install' }

# Add canonical host determined by env but only in production
environment "\nconfig.middleware.use Rack::CanonicalHost, ENV.fetch('APPLICATION_HOST')",
            env: 'production'

# Add APPLICATION_HOST to a sample env
append_file '.sample.env', 'APPLICATION_HOST=localhost:3000'
