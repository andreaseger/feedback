source 'http://rubygems.org'

gem 'rails', '3.0.4'

gem 'haml-rails'
gem 'jquery-rails'
gem 'inherited_resources'
gem 'has_scope'
gem 'simple_form'
gem 'will_paginate', '3.0.pre2'


#MongoDB
gem 'bson_ext'
gem "mongoid", ">= 2.0.0.rc.7"

#security
gem 'net-ldap'
gem "cancan"

# Style
gem "compass", ">= 0.10.6"

group :development do
  gem 'nifty-generators'
  gem 'rails3-generators'
  gem 'backports'   #for the new Randomclass from 1.9.2
  gem 'faker'
end


group :test, :development do
  gem 'rspec-rails'#, '>= 2.5.0'#'>= 2.0.0.beta.22'
  gem 'spork', '>= 0.9.0.rc3'
  gem 'mocha'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'cucumber'
  gem 'cucumber-rails'
  #gem 'launchy'
  #gem 'ruby-debug'
  #gem 'ruby-debug19', :require => 'ruby-debug'

  #irb stuff
  gem 'wirble'
  gem 'hirb'
  gem 'awesome_print'
  gem 'bond'
  gem 'sketches'

  #factories
  gem 'factory_girl_rails', :git => 'git://github.com/thoughtbot/factory_girl_rails.git'
  gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git'

end

group :test do
  #simplecov geht nur in 1.9
  #gem 'simplecov', '>= 0.4.0', :require => false
  gem 'webrat'
  gem 'capybara'
  gem 'database_cleaner'
end

