Webrat.configure do |config|
  config.mode = :selenium
  config.application_framework = :rails
  config.application_environment = :cucumber
  config.selenium_browser_key = "*chrome"
end

require 'selenium/rspec/reporting/system_capture'

World(Webrat::Selenium::Matchers)

Cucumber::Rails::World.use_transactional_fixtures = false

Before do 
  Fixtures.reset_cache
  fixtures_directory = File.join(RAILS_ROOT, 'spec', 'fixtures')
  fixtures = Dir[File.join(fixtures_directory, '*.yml')].map { |f| File.basename(f, '.yml') }
  Fixtures.create_fixtures(fixtures_directory, fixtures)
end

#def wait_for_ajax(timeout = 5000)
#  selenium.wait_for_condition("selenium.browserbot.getCurrentWindow().Ajax.activeRequestCount == 0", timeout)
#end

AfterStep do |scenario|
  #selenium.wait_for_ajax
end

# require 'database_cleaner'
# require 'database_cleaner/cucumber'

# DatabaseCleaner.clean_with :truncation
# DatabaseCleaner.strategy = :truncation

# Before do 
#   DatabaseCleaner.start
# end

# After do 
#   DatabaseCleaner.clean
# end
