gem 'high_voltage'

run 'bundle install'

# Create a basic home page ready for customization

file 'app/views/pages/home.html.erb', <<-CODE
  <% content_for :page_title, 'Home' %>
CODE

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
