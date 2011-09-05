ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'

Cucumber::Rails::World.use_transactional_fixtures = true

ActionController::Base.allow_rescue = false

require 'cucumber/formatter/unicode'
require 'cucumber/web/tableish'
require 'cucumber/rails/rspec'
require 'webrat'
require 'webrat/core/matchers' 

