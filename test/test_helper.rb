require 'minitest/autorun'
require 'minitest/pride'
require 'rankle'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'rankle.sqlite3'
)

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'
