module EngineRoom
  module Generators
    class EngineRoomGenerator < Rails::Generators::Base
      
      namespace "engine_room"
      
      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE), 'templates')
      end
  
      def doit
        puts "generating engine_room..."
      end
  
      #hook_for :devise
    end
  end
end