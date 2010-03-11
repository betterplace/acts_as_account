require 'rubygems'
gem 'mysql', '2.7.0'
gem 'activerecord', '2.0.5'
require 'activerecord'

$: << File.expand_path(File.dirname(__FILE__))

require 'acts_as_account/base'
require 'acts_as_account/account'
require 'acts_as_account/journal'
require 'acts_as_account/posting'
require 'acts_as_account/active_record_extensions'

ActiveRecord::Base.class_eval do
  include ActsAsAccount::ActiveRecordExtension
end
