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

[File.dirname(__FILE__) + '/../../db/migrate',
 'rankle.sqlite3'].each do |path|
  FileUtils::rm_rf(path) if File.exist?(path)
end

Rails::Generators.invoke 'rankle:install'
require File.dirname(__FILE__) + '/../../db/migrate/' + Dir.entries(File.dirname(__FILE__) + '/../../db/migrate').sort.last
CreateRankleIndices.new.migrate :up

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/models.rb'

DatabaseCleaner.strategy = :deletion

class Minitest::Test
  def setup
    DatabaseCleaner.clean
  end
end
