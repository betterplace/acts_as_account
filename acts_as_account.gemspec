# -*- encoding: utf-8 -*-
# stub: acts_as_account 3.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_account".freeze
  s.version = "3.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel".freeze]
  s.date = "2021-02-22"
  s.description = "acts_as_account implements double entry accounting for Rails models. Your models get accounts and you can do consistent transactions between them. Since the documentation is sparse, see the transfer.feature for usage examples.".freeze
  s.email = "developers@betterplace.org".freeze
  s.extra_rdoc_files = ["README.rdoc".freeze, "lib/acts_as_account.rb".freeze, "lib/acts_as_account/account.rb".freeze, "lib/acts_as_account/active_record_extensions.rb".freeze, "lib/acts_as_account/global_account.rb".freeze, "lib/acts_as_account/journal.rb".freeze, "lib/acts_as_account/manually_created_account.rb".freeze, "lib/acts_as_account/posting.rb".freeze, "lib/acts_as_account/rails.rb".freeze, "lib/acts_as_account/transfer.rb".freeze, "lib/acts_as_account/version.rb".freeze]
  s.files = [".gitignore".freeze, ".travis.yml".freeze, "CHANGELOG.md".freeze, "Gemfile".freeze, "LICENSE".freeze, "README.rdoc".freeze, "Rakefile".freeze, "VERSION".freeze, "acts_as_account.gemspec".freeze, "cucumber.yml".freeze, "features/account/account_creation.feature".freeze, "features/db/database.yml".freeze, "features/db/schema.rb".freeze, "features/step_definitions/account_steps.rb".freeze, "features/support/abstract_user.rb".freeze, "features/support/cheque.rb".freeze, "features/support/env.rb".freeze, "features/support/inheriting_user.rb".freeze, "features/support/user.rb".freeze, "features/transfer/journal_creation.feature".freeze, "features/transfer/transfer.feature".freeze, "init.rb".freeze, "lib/acts_as_account.rb".freeze, "lib/acts_as_account/account.rb".freeze, "lib/acts_as_account/active_record_extensions.rb".freeze, "lib/acts_as_account/global_account.rb".freeze, "lib/acts_as_account/journal.rb".freeze, "lib/acts_as_account/manually_created_account.rb".freeze, "lib/acts_as_account/posting.rb".freeze, "lib/acts_as_account/rails.rb".freeze, "lib/acts_as_account/transfer.rb".freeze, "lib/acts_as_account/version.rb".freeze]
  s.homepage = "http://github.com/betterplace/acts_as_account".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rdoc_options = ["--title".freeze, "ActsAsAccount -- More Math in Ruby".freeze, "--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.2.8".freeze
  s.summary = "acts_as_account implements double entry accounting for Rails models".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<gem_hadar>.freeze, ["~> 1.11.0"])
    s.add_development_dependency(%q<cucumber>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<complex_config>.freeze, [">= 0"])
    s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.3"])
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 4.1", "< 7"])
    s.add_runtime_dependency(%q<actionpack>.freeze, [">= 4.1", "< 7"])
  else
    s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.11.0"])
    s.add_dependency(%q<cucumber>.freeze, ["~> 1.3"])
    s.add_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<complex_config>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.3"])
    s.add_dependency(%q<activerecord>.freeze, [">= 4.1", "< 7"])
    s.add_dependency(%q<actionpack>.freeze, [">= 4.1", "< 7"])
  end
end
