# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'acts_as_account'
  author      [ "Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel" ]
  email       'developers@betterplace.org'
  homepage    "https://github.com/betterplace/acts_as_account"
  summary     'acts_as_account implements double entry accounting for Rails models'
  description <<~EOT
    acts_as_account implements double entry accounting for Rails models. Your
    models get accounts and you can do consistent transactions between them.
    Since the documentation is sparse, see the transfer.feature for usage
    examples.
  EOT

  test_dir    'tests'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '.rvmrc',
    '.AppleDouble', 'tags', '.byebug_history', '.DS_Store', '/log/*'
  readme      'README.md'
  title       "#{name.camelize} -- More Math in Ruby"
  licenses << 'Apache-2.0'

  dependency 'activerecord',         '>= 5.1', '<9'
  dependency 'actionpack'  ,         '>= 4.1', '<9'
  development_dependency 'cucumber'
  development_dependency 'sqlite3'
  development_dependency 'mysql2'
  development_dependency 'rspec'
  development_dependency 'simplecov'
  development_dependency 'database_cleaner'
  development_dependency 'rubocop'
  development_dependency 'debug'
end

namespace :features do
  task :connect_database do
    load("#{__dir__}/features/support/db.rb")
  end

  desc "create test database out of db/schema.rb"
  task :create_database => :connect_database do
    load("#{__dir__}/features/db/schema.rb")
  end
end

desc "Run features"
task :features => :'features:create_database' do
  ruby '-S', 'cucumber'
end

task :test => :features
