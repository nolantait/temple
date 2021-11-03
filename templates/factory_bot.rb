run 'spring stop'

gem_group :development, :test do
  gem 'factory_bot_rails'
end

File.open(Rails.root.join('spec/rails_helper.rb'), 'r+') do |file|
  lines = file.each_line.to_a
  config_index = lines.find_index("RSpec.configure do |config|\n")
  lines.insert(
    config_index + 1,
    "  config.include FactoryBot::Syntax::Methods\n"
  )
  file.rewind
  file.write(lines.join)
end
