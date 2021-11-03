# install fontawesome-free via yarn
run 'yarn add @fortawesome/fontawesome-free'

# create css folder and application.scss
unless Dir.exist?('app/javascript/stylesheets')
  run 'mkdir app/javascript/stylesheets'
end

unless File.exist?('app/javascript/stylesheets/application.scss')
  run 'touch app/javascript/stylesheets/application.scss'
end

# add reference to fontawesome-free to application.scss

inject_into_file 'app/javascript/stylesheets/application.scss' do
  <<~EOF
    @import '~@fortawesome/fontawesome-free';
  EOF
end

# add requre of css/application.scss && import of fontawesome-free to application.js
inject_into_file 'app/javascript/packs/application.js' do
  <<~EOF
    require("stylesheets/application.scss")
    import "@fortawesome/fontawesome-free/js/all"
  EOF
end
