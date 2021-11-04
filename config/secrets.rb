# Add secrets configuration file
file 'config/secrets.yml' do
  <<~CONFIG
    shared:
      secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

    development:

    test:

    production:
  CONFIG
end

# Add SECRET_KEY_BASE to sample env
append_to_file '.sample.env', 'SECRET_KEY_BASE=91bc9913b675401b821904056b724f39'
