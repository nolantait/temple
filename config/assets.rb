# Raise errors for missing assets during tests
environment 'config.assets.raise_runtime_errors = true', env: 'test'

# Set cache parameters
environment 'config.public_file_server_headers = { "Cache-Control" => "public, max-age=31557600" }'

# Set assets to quiet
application 'config.assets.quiet = true'

# Add asset host set by env
gsub_file 'config/environments/production.rb',
          "# config.action_controller.asset_host = 'http://assets.example.com'",
          'config.action_controller.asset_host = ENV.fetch("ASSET_HOST", ENV.fetch("APPLICATION_HOST"))'

# Add ASSETS_VERSION to assets initializer
gsub_file 'assets.rb', "'1.0'", 'ENV.fetch("ASSETS_VERSION", "1.0")'

# Add ASSET_HOST and ASSET_VERSION to sample env
append_to_file '.sample.env', 'ASSET_HOST=localhost:3000'
append_to_file '.sample.env', 'ASSETS_VERSION=1.0'
