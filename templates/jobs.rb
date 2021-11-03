gem 'delayed_job_active_record'
run 'bundle install'
run 'rails generate delayed_job:active_record'
rails_command 'db:migrate'

initializer 'delayed_job_config.rb', <<-CODE
  Delayed::Worker.destroy_failed_jobs = false
  Delayed::Worker.sleep_delay = 10
  Delayed::Worker.max_attempts = 3
  Delayed::Worker.max_run_time = 5.minutes
  Delayed::Worker.read_ahead = 20
  Delayed::Worker.default_queue_name = 'default'
  Delayed::Worker.raise_signal_exceptions = :term
CODE

configure_environment 'test', 'config.active_job.queue_adapter = :inline'

inject_into_file(
  'config/application.rb',
  "\n    config.active_job.queue_adapter = :delayed_job",
  before: "\n  end"
)
