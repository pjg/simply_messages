$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'rails'
require 'simply_messages'

require File.join(File.dirname(__FILE__), 'app')

require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc.
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end

RSpec.configure do |config|
  config.mock_with :rspec

  # run migrations
  config.before :all do
    CreateUsers.up unless ActiveRecord::Base.connection.table_exists? 'users'
  end
end
