require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.orm = "mongoid"
Before { DatabaseCleaner.clean; load "#{::Rails.root.to_s}/db/seeds.rb" }

