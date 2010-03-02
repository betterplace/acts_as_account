require 'rubygems'
gem 'activerecord', '2.0.5'
require 'activerecord'


$: << File.expand_path(File.dirname(__FILE__))

require 'acts_as_bank/base'
require 'acts_as_bank/account'
require 'acts_as_bank/journal'
require 'acts_as_bank/posting'
