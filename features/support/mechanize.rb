Webrat.configure do |config|
  config.mode = :mechanize
end

Cucumber::Rails::World.use_transactional_fixtures = true

require 'database_cleaner'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :truncation

Before do 
  DatabaseCleaner.start
end

After do 
  DatabaseCleaner.clean
end
