run 'spring stop'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

run 'bundle install'

rails_command 'generate rspec:install'

run 'rm -rf test' if yes?('Do you want to remove the /test directory?')

append_file 'spec/rails_helper.rb',
            <<~RUBY
              Shoulda::Matchers.configure do |config|
                config.integrate do |with|
                  with.test_framework :rspec
                  with.library :rails
                end
              end
RUBY
