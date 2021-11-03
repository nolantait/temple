gem_group :development do
  gem 'better_errors'
end

Bundler.with_unbundled_env { run 'bundle install' }

inject_into_file 'config/routes.rb/', before: 'end' do
  <<~EOF
    get '404', to: 'errors#not_found'
    get '422', to: 'errors#unacceptable'
    get '500', to: 'errors#internal_error'
  EOF
end

run 'touch app/controllers/errors_controller.rb'

inject_into_file 'app/controllers/errors_controller.rb' do
  <<~EOF
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
  EOF
end

run 'mkdir app/views/errors'
run 'touch app/views/errors/not_found.html.erb'
run 'touch app/views/errors/unacceptable.html.erb'
run 'touch app/views/errors/internal_error.html.erb'
run 'rm public/404.html'
run 'rm public/422.html'
run 'rm public/500.html'
