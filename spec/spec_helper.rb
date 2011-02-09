require 'rubygems'
require 'spork'
#require 'simplecov'
#SimpleCov.start 'rails'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    # config.mock_with :rspec

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongo_mapper"

    config.before(:each) do
      DatabaseCleaner.clean
    end

  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

