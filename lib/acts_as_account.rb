require 'active_record'
require 'action_controller'

$: << File.expand_path(File.dirname(__FILE__))

require 'acts_as_account/transfer'
require 'acts_as_account/account'
require 'acts_as_account/journal'
require 'acts_as_account/posting'
require 'acts_as_account/active_record_extensions'

ActiveRecord::Base.class_eval do
  include ActsAsAccount::ActiveRecordExtension
end

require 'acts_as_account/global_account'
require 'acts_as_account/manually_created_account'