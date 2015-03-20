require 'rankle'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'rankle.sqlite3'
)

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/models.rb'