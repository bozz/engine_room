require 'rails/generators/active_record'

module EngineRoom
  module Generators
    class SetupGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def doit
        puts "generating setup..."
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def devise
        migration_template "001_devise_create_users.rb", "db/migrate/devise_create_users.rb"
      end

      def setup
        migration_template "002_create_sections.rb", "db/migrate/create_sections.rb"
        migration_template "003_create_fields.rb", "db/migrate/create_fields.rb"

        copy_file 'initializer.rb', 'config/initializers/engine_room.rb'
      end
    end
  end
end
