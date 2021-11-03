def add_external_template(url)
  run "rails app:template LOCATION=#{url}"
end

def external_mixin(type, filename)
  source = 'https://raw.githubusercontent.com'
  branch = 'nolantait/temple/master'
  url = "#{source}/#{branch}/#{type}/#{filename}.rb"
  add_external_template url
end

def mixin(type, filename)
  path = "#{__dir__}/#{type}/#{filename}.rb"
  add_external_template path
end

def add_gem(filename)
  mixin('gems', filename)
end

def add_template(filename)
  mixin('templates', filename)
end

def add_javascript(filename)
  mixin('javascript', filename)
end

def create_bin(name, command = nil)
  file "bin/#{name}" do
    <<~BIN
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
    BIN
  end
  `chmod +x bin/#{name}`
end
