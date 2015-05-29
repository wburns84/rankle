require 'minitest/autorun'
require 'minitest/pride'
require 'rankle'
require 'database_cleaner'

ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'rankle.sqlite3'
)

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/models.rb'

DatabaseCleaner.strategy = :truncation

class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
