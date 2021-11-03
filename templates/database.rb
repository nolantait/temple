require 'utils'

puts 'Adding bullet...'
add_gem 'bullet'

remove_file 'config/database.yml'
create_file 'config/database.yml' do
  <<~CONFIG
    development: &default
      adapter: postgresql
      database: #{app_name}_development
      encoding: utf8
      min_messages: warning
      pool: <%= Integer(ENV.fetch("DB_POOL", 5)) %>
      reaping_frequency: <%= Integer(ENV.fetch("DB_REAPING_FREQUENCY", 10)) %>
      timeout: 5000
      url:  <%= ENV["DATABASE_URL"] %>

    test:
      <<: *default
      database: #{app_name}_test

    production: &deploy
      encoding: utf8
      min_messages: warning
      pool: <%= [Integer(ENV.fetch("MAX_THREADS", 5)), Integer(ENV.fetch("DB_POOL", 5))].max %>
      timeout: 5000
      url:  <%= ENV.fetch("DATABASE_URL", "") %>
  CONFIG
end

initializer 'bullet.rb' do
  <<~CONFIG
    if defined? Bullet
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
      Bullet.honeybadger = true
    end
  CONFIG
end

rails_command 'db:drop'
rails_command 'db:create'
rails_command 'db:migrate'
