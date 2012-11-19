$:.unshift File.expand_path("../../..", __FILE__)
require 'test/unit/assertions'

World(Test::Unit::Assertions)

require 'rails'
require 'active_record'

require File.dirname(__FILE__) + '/../../lib/acts_as_account'

ActiveRecord::Base.class_eval do
  include ActsAsAccount::ActiveRecordExtension
end

require 'app/models/account'
require 'app/models/global_account'
require 'app/models/journal'
require 'app/models/manually_created_account'
require 'app/models/posting'

ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + '/../../db/database.yml')['acts_as_account'])

#ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :transaction

Dir[File.dirname(__FILE__) + '/../step_definitions/*.rb'].each { |file| require file }

require File.dirname(__FILE__) + '/user'
require File.dirname(__FILE__) + '/abstract_user'
require File.dirname(__FILE__) + '/inheriting_user'
require File.dirname(__FILE__) + '/cheque'

After do
 Journal.clear_current
end
