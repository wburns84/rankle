require 'rails/generators/base'

module Rankle
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates/', __FILE__)

      def generate_migration
        migration_template 'migration.rb', 'db/migrate/create_rankle_indices.rb'
      end

      def self.next_migration_number(dir)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
    end
  end
end
