# Install gem and run bundle install
gem 'activejob'
Bundler.with_unbundled_env { run 'bundle install' }
# Require active_job railtie so we can call active job in rails without error
insert_into_file 'config/application.rb',
                 "\nrequire 'active_job/railtie'",
                 after: 'require "rails"'

# Add ApplicationJob as base job class
file 'app/jobs/application_job.rb' do
  <<~TEMPLATE
    class ApplicationJob < ActiveJob::Base
      # Automatically retry jobs that encountered a deadlock
      # retry_on ActiveRecord::Deadlocked
      # Most jobs are safe to ignore if the underlying records are no longer available
      # discard_on ActiveJob::DeserializationError
    end
  TEMPLATE
end
