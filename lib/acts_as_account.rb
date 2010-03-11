require 'activerecord'
require 'action_controller'

$: << File.expand_path(File.dirname(__FILE__))

require 'acts_as_account/base'
require 'acts_as_account/account'
require 'acts_as_account/journal'
require 'acts_as_account/posting'
require 'acts_as_account/active_record_extensions'
require 'acts_as_account/action_controller_extensions'

ActiveRecord::Base.class_eval do
  include ActsAsAccount::ActiveRecordExtension
end

ActionController::Base.class_eval do
  include ActsAsAccount::ActionControllerExtensions
end

require 'acts_as_account/global_account'