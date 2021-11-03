gem_group :development do
  gem 'bullet'
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
