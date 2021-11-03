# Install gem and run bundle install
gem 'delayed_job_active_record'
Bundler.with_unbundled_env { run 'bundle install' }

# Generate and run migrations
generate 'delayed_job:active_record'
rails_command 'db:migrate'

# Setup delayed job configuration
initializer 'delayed_job_config.rb', <<-CODE
  Delayed::Worker.destroy_failed_jobs = false
  Delayed::Worker.sleep_delay = 10
  Delayed::Worker.max_attempts = 3
  Delayed::Worker.max_run_time = 5.minutes
  Delayed::Worker.read_ahead = 20
  Delayed::Worker.default_queue_name = 'default'
  Delayed::Worker.raise_signal_exceptions = :term
CODE

# Add delayed job as the queue adapter and override on test environment so jobs
# don't run asynchronously
application 'config.active_job.queue_adapter = :delayed_job'
environment 'config.active_job.queue_adapter = :inline', env: 'test'
