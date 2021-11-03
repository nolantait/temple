# PG gem is added with rails bootstrap

gem_group :development do
  gem 'bullet'
end

Bundler.with_unbundled_env { run 'bundle install' }

remove_file 'config/database.yml'
create_file 'config/database.yml' do
  <<~EOF
    development: &default
      adapter: postgresql
      database: <%= app_name %>_development
      encoding: utf8
      min_messages: warning
      pool: <%= Integer(ENV.fetch("DB_POOL", 5)) %>
      reaping_frequency: <%= Integer(ENV.fetch("DB_REAPING_FREQUENCY", 10)) %>
      timeout: 5000
      url:  <%= ENV["DATABASE_URL"] %>

    test:
      <<: *default
      database: <%= app_name %>_test

    production: &deploy
      encoding: utf8
      min_messages: warning
      pool: <%= [Integer(ENV.fetch("MAX_THREADS", 5)), Integer(ENV.fetch("DB_POOL", 5))].max %>
      timeout: 5000
      url:  <%= ENV.fetch("DATABASE_URL", "") %>
  EOF
end

run 'touch config/initializers/bullet.rb'

inject_into_file 'config/initializers/bullet.rb' do
  <<~EOF
    if defined? Bullet
      Bullet.enable = true
      Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
      Bullet.growl = true
      Bullet.rails_logger = true
      Bullet.honeybadger = true
      Bullet.add_footer = true
      Bullet.skip_html_injection = false
    end
  EOF
end

rails_command('db:drop')
rails_command('db:create')
rails_command('db:migrate')
