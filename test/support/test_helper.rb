require 'minitest/autorun'
require 'minitest/pride'
require 'rankle'
require 'database_cleaner'
require 'rails/generators'
require 'rake'

ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'rankle.sqlite3'
)

rake = Rake.application
rake.init
rake.load_rakefile
Dir.entries(File.dirname(__FILE__) + '/../../db/migrate').each do |filename|
  File.delete(File.dirname(__FILE__) + '/../../db/migrate/' + filename) rescue nil
end
Rails::Generators.invoke 'rankle:install'
require File.dirname(__FILE__) + '/../../db/migrate/' + Dir.entries(File.dirname(__FILE__) + '/../../db/migrate').sort.last
File.delete 'rankle.sqlite3'
CreateRankleIndices.new.migrate :up

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/models.rb'

DatabaseCleaner.strategy = :deletion

class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
