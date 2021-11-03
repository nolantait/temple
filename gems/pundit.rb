run 'bundle add pundit'
puts 'Adding Pundit module to Application'
puts ''

inject_into_file 'app/controllers/application_controller.rb',
                 after:
                   "class ApplicationController < ActionController::Base\n" do
  "  include Pundit\n"
end

puts 'Running Pundit Generator'
rails_command('generate pundit:install')
