def configure_environment(rails_env, config)
  inject_into_file(
    "config/environments/#{rails_env}.rb",
    "\n  #{config}",
    before: "\nend"
  )
end
gem 'activejob'
gem 'delayed_job_active_record'

Bundler.with_unbundled_env { run 'bundle install' }

# add requre of css/application.scss && import of fontawesome-free to application.js
create_file 'app/jobs/application_job.rb' do
  <<~EOF
    class ApplicationJob < ActiveJob::Base
      # Automatically retry jobs that encountered a deadlock
      # retry_on ActiveRecord::Deadlocked
      # Most jobs are safe to ignore if the underlying records are no longer available
      # discard_on ActiveJob::DeserializationError
    end
  EOF
end

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
