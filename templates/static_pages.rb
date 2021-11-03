require_relative '../utils'

puts 'Adding high voltage...'
add_gem 'high_voltage'

# Add basic homepage
file 'app/views/pages/home.html.erb', <<-CODE
  <h1>Hello world.</h1>
CODE

# Add static page layout
file 'app/views/layouts/static_page.html.erb', <<~CODE
  <!DOCTYPE html>
  <html>
    <head>
      <title><%= yield(:page_title) %></title>
      <%= csrf_meta_tags %>
      <%= csp_meta_tag %>
      <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
      <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    </head>

    <body>
      <%= yield %>
    </body>
  </html>
CODE

# Configure High Voltage page as root and use static_page as the layout
# https://github.com/thoughtbot/high_voltage#specifying-a-root-path
# make other pages top-level routes as well
# https://github.com/thoughtbot/high_voltage#top-level-routes
initializer 'high_voltage.rb', <<-CODE
  HighVoltage.configure do |config|
    config.home_page = 'home'
    config.route_drawer = HighVoltage::RouteDrawers::Root
    config.layout = 'static_page'
  end
CODE
