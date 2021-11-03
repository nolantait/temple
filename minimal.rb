def add_external_template(url)
  run "rails app:template LOCATION=#{url}"
end

def add_template(filename)
  add_external_template "https://raw.githubusercontent.com/nolantait/temple/master/templates/#{filename}.rb"
end

puts 'Adding testing with RSpec...'
add_template 'testing'

puts 'Adding static pages with High Voltage...'
add_template 'static_pages'

puts 'Adding delayed job...'
add_template 'jobs'

puts 'Add custom errors...'
add_template 'errors'

puts 'Add database configuration...'
add_template 'database'

puts 'Add css gems...'
add_template 'css'

puts 'Add dryrb gems...'
add_template 'dry'

puts 'Add linting...'
add_template 'linting'

puts 'Add security gems...'
add_template 'security'

puts 'Add forms with SimpleForm...'
add_template 'forms'
