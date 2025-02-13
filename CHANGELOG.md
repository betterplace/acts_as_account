# Changes

## 2025-02-13 v3.5.1

* Update some dependencies.

## 2025-01-07 v3.5.0

* Relax `active_record` and `action_view` dependencies to allow for Rails 8
  compatibility.
* Updated `acts_as_account.gemspec`.

## 2024-11-01 v3.4.2

* Add compact to attributes handling of transfer method:
  + Use `posting1.attributes.compact` and `posting2.attributes.compact` instead
    of just `posting1.attributes` and `posting2.attributes`.
* Update logging configuration and ignore log files:
  + Update `DATABASE_LOG` handling in `features/support/env.rb`
  + Add `log/*` to `.gitignore`
  + Modify `transfer` method in `lib/acts_as_account/journal.rb` to safely
    reference objects.
  + Added log directory
* Add mysql for database testing:
  + Add `mysql2` as a development dependency to Gemfile
  + Update `acts_as_account.gemspec` to reflect new dependencies and version
  + Update Rakefile to be able to use `mysql2` for connecting to MySQL database
  + Add Docker Compose file for running MySQL service for testing
  + Update database.yml files to point to MySQL or SQLite databases
  + Create a new file features/support/db.rb for setting up the database connection
* Update copyright year upto **2024**

## 2024-10-28 v3.4.1

* Improved account management features:
  * Update `Journal.current.transfer` to return a boolean value indicating success.
  * Modify `transfer()` method in `lib/acts_as_account/journal.rb` to
    check the result of `postings.model.insert_all`.
  * Validate the transfer result in `german_date_time_to_local` and `When /^I
    transfer ...$` step definitions.

## 2024-10-28 v3.4.0

* Improve Journaling for Transfer Operations:
  + Renamed `add_posting` to `build_posting` in `ActsAsAccount::Journal`
  + Replaced direct database insertion with two insert statements with a call to `model.insert_all` in `transfer` method
  + Updated `update_attributes_on` to directly count amounts of postings
* Ensure consistent locking order for account transfers:
  + Use each if we aren't interested in the `lock!` results
  + Make if condition readable even on smaller displays
* Improved logging for transfer method in Journal class:
  + Improved formatting of debug message using array.join.
  + Improved indenting of comment
* Improved journal functionality for transfers:
  + Replaced `tap` with a more concise implementation using `map`

## 2024-10-23 v3.3.0

* Make persistence of `#postings_count` and `#balance` configurable for accounts:
  + Only lock if configuration is set to persist these attributes
  + Rename `recalculate_all_balances` to `recalculate_attributes` and deprecate
    the original method
* Make gem configurable:
  + Add configuration option `persist_attributes_on_account` for persistence of `postings_count` and `balance`
* Update dependencies and Ruby version:
  + Update to newer Ruby version and dependencies
* Review and README adjustments:
  + Perform review and make adjustments to README file
* Fix typo:
  + Correct a typo in the code

## 2022-07-20 v3.2.3

* Loosen Rails dependencies to now be less than **8**.
* Use experimental, new web-protocol for links (`HTTP::Link`).
* Neaten README and update copyright information.
* Remove dependency on `cc` gem (broken on Ruby-head).
* Test only on MRI (Ruby Implementation).
* Fix linter issue.
* Use SQLite for tests.
* Use GitHub Actions.

## 2021-02-22 v3.2.2

* Make `database_cleaner` a development dependency
* Support **Rails 6**
* Fix specs for recent versions of **Rails**

## 2016-12-08 v3.2.0

* Be compatible with Rails **5**.
* Call `rake` instead of just mentioning it.
* Do not check in `Gemfile.lock`.
* Drop support for Ruby **1.9.2**.
* Add support for Ruby **2.3.0**.
* Update gems and Travis settings to use containers, adding a Travis badge.

## 2015-01-22 v3.1.2

* Removed `.ruby` files.
* Regenerated `gemspec` for **3.1.1** and **2.0.3** versions.
* Ignored ruby-version.

## 2015-01-14 v3.1.1

* Corrected posting scope for Rails 4: The `posting_scope` method was updated
  to correctly handle UTC times stored in the database.
* Compare UTC times to values in database: The code now parses specified dates
  and converts them to the database format of their UTC time, ensuring correct
  range finding.
* Be less strict in depending on **4.1**: The gem's dependencies were relaxed
  to be less strict about requiring version **4.1**.
* Update LICENSE: The license was changed from an unknown type to Apache
  License.
* Regenerate gemspec for `version 3.1.0`: The gemspec was regenerated for the
  new version.
* Adds Changelog and Rails 4 notice: A changelog and a notice about supporting
  Rails 4 were added.
* Regenerate gemspec for `version 2.0.3`: The gemspec was regenerated for the
  new version.
* Regenerate gemspec for `version 3.1.1`: The gemspec was regenerated for the
  new version.

## 2014-04-25 v3.1.0

* Added Rails 4.1 compatibility.
* Regenerated gemspec for `**3.1.0**`.
* Updated LICENSE to use the Apache License.

## 2013-12-17 v3.0.0

* Adds **Rails 4** compatibility
* Uses `update_counters` to solve concurrency issues and treat account balances
  like other counters in Rails, replacing previous method that would undo lock
  on account rows by reloading them.

## 2014-09-18 v2.0.2

* Repair building with `jewel`
* Add `travis` configuration
* Specify gem dependencies
* Update LICENSE to Apache License
* Compare UTC times to values in database:
  + Parse specified dates and convert them to the db format of their UTC time.

## 2012-10-04 v2.0.1

* Regenerate gemspec for **2.0.1**
* Fixed problem that broke STI classes that used `has_account` in Rails 3.x
* Updated gemspec to reflect changes

## 2012-09-10 v2.0.0

* Upgrade `acts_as_account` to work with Rails **3**.
* Significant changes:
  + Renamed `VERSION` file
  + Updated `acts_as_account.gemspec`
  + Modified `lib/acts_as_account/journal.rb`
  + Modified `lib/acts_as_account/posting.rb`

## 2012-07-31 v1.2.0

* Regenerate gemspec for `version 1.2.0`
* Updated `version` to use with default STI naming setup for Rails >= **2.3**
* Added method `BetterPlace::Model::Base#sti_name` 
* Renamed method `BetterPlace::Model::Base#table_name`

## 2012-03-12 v1.1.6

* **Fixed bug in active_record_extensions**: `holder_id` and type are now
  passed through correctly.
* Changed `returning` to `#tap` to remove warnings.
* More fixes for tests and rake task.
* Fixed calculation of account balances.

## 2010-11-15 v1.1.5

* Fixed dependency:
  + Updated `Gemfile` to use the latest version of `rails`
  + Removed unused `mysql2` gem
* Significant changes:
  + Added a new method, `create_user`, to the `User` model (`def
    create_user(**kwargs)`)
  + Updated the `login` method in the `SessionController` to use the
    `create_user` method (`def login; @user = User.create_user(**params); end`)
  + Changed the default value of the `admin` attribute in the `User` model from
    `false` to `true` (`attr_accessor :admin, default: true`)

## 2010-11-12 v1.1.4

* Fixed dependency bug:
  + Updated the project to use `Gemfile` instead of `config.gem`
  + Removed reference to deprecated `config.gem` in favor of `Gemfile` 
  + Added `gem 'mysql2', '~> **1.0**'` to `Gemfile`

## 2010-11-12 v1.1.3

* Fixed dependency bug:
  + Updated `BetterPlace::DependencyManager` to use correct version of `Gem`
    (now using `Gem::Version.new('1.3.7')`)
  + Added check for missing dependencies in
    `BetterPlace::Project#load_dependencies`
* Version bump: **1.1.3**

## 2010-11-12 v1.1.2

* Added some methods:
  + `BetterPlace::Project#new` now takes an optional `:api_key` parameter
  + `BetterPlace::Project#fetch_data` now fetches data from the Better Place
    API using the provided `:api_key`
* Modified README and Rakefile

## 2010-11-12 v1.1.0

  * Start
