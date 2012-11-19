# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_account/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_account"
  s.version     = ActsAsAccount::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel", "Mauro Asprea"]
  s.date = "2012-11-08"
  s.description = "acts_as_account implements double entry accounting for Rails models. Your models get accounts and you can do consistent transactions between them. Since the documentation is sparse, see the transfer.feature for usage examples."
  s.email = "thieso@gmail.com"
  s.homepage = "http://github.com/betterplace/acts_as_account"
  s.require_paths = ["lib"]
  s.summary = "acts_as_account implements double entry accounting for Rails models"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_development_dependency 'rails', '~>3.2.9'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'cucumber'
end
