require 'rails/generators/active_record'

module EngineRoom
  module Generators
    class CreateImageGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def doit
        puts "generating image model..."
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def copy_files
        migration_template "004_create_images.rb", "db/migrate/create_images.rb"
        copy_file "image.rb", "app/models/image.rb"
      end
    end
  end
end
