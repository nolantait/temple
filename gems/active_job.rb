# Install gem and run bundle install
gem 'activejob'
Bundler.with_unbundled_env { run 'bundle install' }

# Add ApplicationJob as base job class
file 'app/jobs/application_job.rb' do
  <<~EOF
    class ApplicationJob < ActiveJob::Base
      # Automatically retry jobs that encountered a deadlock
      # retry_on ActiveRecord::Deadlocked
      # Most jobs are safe to ignore if the underlying records are no longer available
      # discard_on ActiveJob::DeserializationError
    end
  EOF
end

# Require active_job railtie so we can call active job in rails without error
application 'require active_job/railtie'
