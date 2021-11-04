require_relative '../utils'

puts 'Adding heroku...'
add_gem 'heroku'

def run_heroku_command(command, environment)
  run "heroku #{command} --remote #{environment}"
end

def formatted_app_name
  app_name.dasherize
end

def heroku_app_name(environment)
  "#{formatted_app_name}-#{environment}"
end

def generate_secret
  SecureRandom.hex(64)
end

%w[staging production].each do |environment|
  # Create a new heroku app
  run_heroku_command "create #{heroku_app_name(environment)}", environment

  # Add buildpacks for nodejs and ruby
  run_heroku_command 'buildpacks:add --index 1 heroku/nodejs', environment
  run_heroku_command 'buildpacks:add --index 2 heroku/ruby', environment

  # Set environment variables
  run_heroku_command "config:add APPLICATION_HOST=#{heroku_app_name(environment)}.herokuapp.com",
                     environment
  run_heroku_command "config:add SECRET_KEY_BASE=#{generate_secret}",
                     environment

  # Schedule pg backups
  run_heroku_command "pg:backups:schedule DATABASE_URL --at '10:00 UTC'",
                     environment

  # Add heroku server to git remote
  git remote:
        "add #{environment} git@heroku.com:#{heroku_app_name(environment)}.git"
end

# Setup heroku pipeline for deployment
run_heroku_command "pipelines:create #{formatted_app_name} -a #{heroku_app_name('staging')} --stage staging",
                   'staging'
run_heroku_command "pipelines:create #{formatted_app_name} -a #{heroku_app_name('production')} --stage production",
                   'production'

# Set staging as the default app for heroku toolbelt
git config: 'heroku.remote staging'
