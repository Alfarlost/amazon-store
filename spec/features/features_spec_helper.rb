require 'spec_helper'
require 'capybara/rspec'
require 'rack_session_access/capybara'

include Warden::Test::Helpers
Warden.test_mode!
 
Rails.application.config do
  config.middleware.use RackSessionAccess::Middleware
end
