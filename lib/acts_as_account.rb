require 'active_record'
require 'action_controller'
require 'acts_as_account/configuration'

module ActsAsAccount
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end

require 'acts_as_account/version'
require 'acts_as_account/transfer'
require 'acts_as_account/account'
require 'acts_as_account/journal'
require 'acts_as_account/posting'
require 'acts_as_account/active_record_extensions'
require 'acts_as_account/rails'
require 'acts_as_account/global_account'
require 'acts_as_account/manually_created_account'
