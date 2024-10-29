require 'active_record'
require 'yaml'
db_type   = ENV.fetch('DATABASE_TYPE', 'sqlite')
db_config = YAML.load_file('features/db/database.yml').fetch(db_type)
if db_type == 'mysql'
  ActiveRecord::Base.establish_connection(db_config.except('database')).with_connection do |c|
    c.execute p %{CREATE DATABASE IF NOT EXISTS #{db_config.fetch('database')}}
  end
end
ActiveRecord::Base.establish_connection(db_config).with_connection do |c|
  c.execute %{ SELECT 1}
end
