require File.dirname(__FILE__) + '/../../lib/acts_as_account'
ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + '/../../db/database.yml')['acts_as_account'])

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :transaction

Dir[File.dirname(__FILE__) + '/../step_definitions/*.rb'].each { |file| require file }

require File.dirname(__FILE__) + '/user'
require File.dirname(__FILE__) + '/abstract_user'
require File.dirname(__FILE__) + '/inheriting_user'
require File.dirname(__FILE__) + '/cheque'

After do
  ActsAsAccount::Journal.clear_current
end
