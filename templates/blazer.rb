run 'bundle add blazer'
rails_command 'generate blazer:install'
rails_command 'db:migrate'

inject_into_file 'app/config/routes.rb',
                 after: 'Rails.application.routes.draw do' do
  <<~EOF
    mount Blazer::Engine, at: "blazer"
  EOF
end
