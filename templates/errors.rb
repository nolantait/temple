require 'utils'

puts 'Adding better errors...'
add_gem 'better_errors'

route "get '404', to: 'errors#not_found'"
route "get '422', to: 'errors#unacceptable'"
route "get '500', to: 'errors#internal_error'"

file 'app/controllers/errors_controller.rb' do
  <<~CONTROLLER
    class ErrorsController < ApplicationController
      def not_found
        respond_to do |format|
          format.html { render status: 404 }
        end
      end

      def unacceptable
        respond_to do |format|
          format.html { render status: 422 }
        end
      end

      def internal_error
        respond_to do |format|
          format.html { render status: 500 }
        end
      end
    end
  CONTROLLER
end

file 'app/views/errors/not_found.html.erb'
file 'app/views/errors/unacceptable.html.erb'
file 'app/views/errors/internal_error.html.erb'

run 'rm public/404.html'
run 'rm public/422.html'
run 'rm public/500.html'
