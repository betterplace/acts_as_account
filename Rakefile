# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'acts_as_account'
  author      [ "Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel" ]
  email       'developers@betterplace.org'
  homepage    "http://github.com/betterplace/acts_as_account"
  summary     'acts_as_account implements double entry accounting for Rails models'
  description 'acts_as_account implements double entry accounting for Rails models. Your models get accounts and you can do consistent transactions between them. Since the documentation is sparse, see the transfer.feature for usage examples.'
  test_dir    'tests'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '.rvmrc',
    '.AppleDouble', 'tags', '.byebug_history', '.DS_Store'
  readme      'README.rdoc'
  title       "#{name.camelize} -- More Math in Ruby"
  licenses << 'Apache-2.0'

  dependency 'activerecord',         '>= 4.1', '<7'
  dependency 'actionpack'  ,         '>= 4.1', '<7'
  development_dependency 'cucumber', '~> 1.3'
  development_dependency 'sqlite3'
  development_dependency 'rspec',    '~> 3.1'
  development_dependency 'simplecov'
  development_dependency 'database_cleaner',     '~> 1.3'
  development_dependency 'rubocop'
end

def connect_database
  require 'active_record'
  require 'yaml'
  db_config = YAML.load_file('features/db/database.yml')
  ActiveRecord::Base.establish_connection(db_config).connection
end

namespace :features do
  desc "create test database out of db/schema.rb"
  task :create_database do
    connect_database
    load("#{__dir__}/features/db/schema.rb")
  end
end

desc "Run features"
task :features => :'features:create_database' do
  ruby '-S', 'cucumber'
end

task :test => :features
