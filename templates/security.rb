require 'utils'

puts 'Adding brakeman...'
add_gem 'brakeman'

# Force SSL in production
environment 'config.force_ssl = true', env: 'production'
