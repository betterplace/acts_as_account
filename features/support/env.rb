require 'rubygems'
gem 'mysql', '2.7.0'
gem 'activerecord'
gem 'actionpack'

require 'test/unit/assertions'
World(Test::Unit::Assertions)

require File.dirname(__FILE__) + '/../../lib/acts_as_account'

ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + '/../../db/database.yml')['acts_as_account'])
#ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :transaction

Dir[File.dirname(__FILE__) + '/../step_definitions/*.rb'].each { |file| require file }

require File.dirname(__FILE__) + '/user'
require File.dirname(__FILE__) + '/cheque'

After do
  begin
    ActsAsAccount::Journal.clear_current
  rescue ActsAsAccount::Journal::UncommitedError
  end
end

