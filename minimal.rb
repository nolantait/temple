require 'utils'

puts 'Mixing database...'
add_template 'database'

puts 'Mixing testing...'
add_template 'testing'

puts 'Mixing static pages...'
add_template 'static_pages'

puts 'Mixing jobs...'
add_template 'jobs'

puts 'Mixing custom errors...'
add_template 'errors'

puts 'Mixing dryrb gems...'
add_template 'dry'

puts 'Mixing linting...'
add_template 'linting'

puts 'Mixing security...'
add_template 'security'
