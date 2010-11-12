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

      # override - is it necessary?
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      

      def devise
        migration_template "001_devise_create_users.rb", "db/migrate/devise_create_users.rb"
        
        #invoke "devise:install"
        #invoke :devise "User"
      end
      
    end
  end
end