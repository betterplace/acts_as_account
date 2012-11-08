$: << File.expand_path(File.dirname(__FILE__))

require 'acts_as_account/transfer'
require 'acts_as_account/active_record_extensions'

if ::Rails::VERSION::MAJOR == 3
  require 'acts_as_account/engine'
end