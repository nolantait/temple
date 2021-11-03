run 'spring stop'

gem 'dry-struct'
gem 'dry-types'
gem 'dry-initializer'

create_file 'app/models/types.rb' do
  <<~EOF
    require "dry-types"

    module Types
      include Dry.Types()
    end
  EOF
end
