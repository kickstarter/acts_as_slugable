$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)
ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require "#{File.dirname(__FILE__)}/../init"

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'plugin_test'])

ActiveRecord::Migration.verbose = false
load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/fixtures/")

class ActiveSupport::TestCase #:nodoc:
  include ActiveRecord::TestFixtures
  
  self.fixture_path = File.dirname(__FILE__) + '/fixtures/'
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  fixtures :all
end
