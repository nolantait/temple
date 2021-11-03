# Check if they need us to add webpacker for them.
run 'bundle add webpacker' unless defined?(Webpacker)

# Install the package and then run yarn afterwards.
rails_command 'webpacker:install:react'
