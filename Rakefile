require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
  Bundler.require(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_account"
    gem.summary = %Q{acts_as_account implements double entry accounting for Rails models}
    gem.description = %Q{acts_as_account implements double entry accounting for Rails models. Your models get accounts and you can do consistent transactions between them. Since the documentation is sparse, see the transfer.feature for usage examples.}
    gem.email = "thieso@gmail.com"
    gem.homepage = "http://github.com/betterplace/acts_as_account"
    gem.authors = ["Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel"]
    gem.license = 'Apache-2.0'
    #gem.add_dependency 'activerecord'
    #gem.add_dependency 'actionpack'
    #gem.add_dependency 'database_cleaner'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

def connect_database
  require 'rubygems'
  require 'active_record'
  access_data = YAML.load_file(File.dirname(__FILE__) + '/db/database.yml')['acts_as_account']
  ActiveRecord::Base.establish_connection(Hash[access_data.select { |k, v| k != 'database'}]).connection
end

namespace :features do
  desc "create test database out of db/schema.rb"
  task :create_database do
    conn = connect_database
    conn.execute('DROP DATABASE IF EXISTS acts_as_account')
    conn.execute('CREATE DATABASE acts_as_account')
    conn.execute('USE acts_as_account')
    load(File.dirname(__FILE__) + '/db/schema.rb')
  end
end

desc "Run features"
task :features => :'features:create_database' do
  ruby '-S', 'cucumber'
end

task :default => :features
