if ENV['START_SIMPLECOV'].to_i == 1
  require 'simplecov'
  SimpleCov.start do
    add_filter 'features'
  end
end

require 'acts_as_account'
require 'yaml'
db_config = YAML.load_file(__dir__ + '/../db/database.yml')
ActiveRecord::Base.establish_connection(db_config)

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :transaction

Dir["#{__dir__}/../step_definitions/*.rb"].sort.each { |file| require file }

require_relative 'user'
require_relative 'abstract_user'
require_relative 'inheriting_user'
require_relative 'cheque'

After do
  ActsAsAccount::Journal.clear_current
end

Before do
  ActsAsAccount.configure do |config|
    # folowing are default values
    # config.persist_postings_count = true
    # config.persist_balance = true
  end
end
