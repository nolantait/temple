gem_group :development, :test do
  gem 'shoulda-matchers'
end

Bundler.with_unbundled_env { run 'bundle install' }

append_to_file 'spec/rails_helper.rb' do
  <<~RUBY
    \nShoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end
  RUBY
end
