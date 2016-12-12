if ENV['START_SIMPLECOV'].to_i == 1
  require 'simplecov'
  SimpleCov.start do
    add_filter 'features'
  end
end

require 'acts_as_account'
require 'complex_config'
config =ComplexConfig::Provider.config File.dirname(__FILE__) + '/../db/database.yml'
ActiveRecord::Base.establish_connection(config.acts_as_account.to_h)

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
