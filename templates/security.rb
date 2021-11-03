def create_bin(name, command = nil)
  create_file "bin/#{name}" do
    <<~EOF
      #!/usr/bin/env ruby
      APP_ROOT = File.expand_path('..', __dir__)
      Dir.chdir(APP_ROOT) do
        begin
          exec '#{command || name}'
        rescue Errno::ENOENT
          $stderr.puts "#{name} executable was not detected in the system."
          exit 1
        end
      end
    EOF
  end
  `chmod +x bin/#{name}`
end

gem_group :development do
  gem 'brakeman'
end

Bundler.with_unbundled_env { run 'bundle install' }

environment 'config.force_ssl = true', env: 'production'

create_bin 'brakeman'
