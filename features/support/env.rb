require 'test/unit/assertions'
World(Test::Unit::Assertions)

require File.dirname(__FILE__) + '/../../lib/acts_as_account'

ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + '/../../db/database.yml')['acts_as_account'])
ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :transaction
