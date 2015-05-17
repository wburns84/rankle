require 'rankle'
require 'database_cleaner'
require 'factory_girl'

DatabaseCleaner.strategy = :truncation

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'rankle.sqlite3'
)

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/models.rb'

World FactoryGirl::Syntax::Methods