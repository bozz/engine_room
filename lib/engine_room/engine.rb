module EngineRoom
  class Engine < Rails::Engine

    config.mount_at = '/'
    
    # Load rake tasks
    rake_tasks do
      #load File.join(File.dirname(__FILE__), 'rails/railties/tasks.rake')
      load "engine_room/railties/tasks.rake"
    end
    
    # Check the gem config
    initializer "check config" do |app|
      # make sure mount_at ends with trailing slash
      config.mount_at += '/'  unless config.mount_at.last == '/'
    end
    
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
      # app.middleware.insert_after ActionDispatch::Static, ActionDispatch::Static, "#{root}/public"
    end
    
    # TODO: move override into external module (couldn't get it working)
    # override paths for Devise after sign-in and sign-out
    initializer 'override ActionController' do |app|  
      
      require 'crummy'
      
      # monkeypatch override: last breadcrumb should not be a link
      module Crummy::ViewMethods
        def render_crumbs(options = {})
          options[:format] = :html if options[:format] == nil
          if options[:seperator] == nil
            options[:seperator] = " &raquo; " if options[:format] == :html
            options[:seperator] = "crumb" if options[:format] == :xml
          end
          options[:links] = true if options[:links] == nil
          case options[:format]
          when :html
            crumb_string = crumbs.collect do |crumb|
              crumb_to_html crumb, crumbs.last==crumb ? false : options[:links]
            end * options[:seperator]
            crumb_string = crumb_string.html_safe if crumb_string.respond_to?(:html_safe)
            crumb_string
          when :xml
            crumbs.collect do |crumb|
              crumb_to_xml crumb, options[:links], options[:seperator]
            end * ''
          else
            raise "Unknown breadcrumb output format"
          end
        end
      end
      
      ActionController::Base.send :include, Crummy::ControllerMethods
      ActionView::Base.send :include, Crummy::ViewMethods
      
      ActiveSupport.on_load(:action_controller) do  
        class ActionController::Base
          def after_sign_in_path_for(resource)
            engine_room_root_path
          end
          def after_sign_out_path_for(resource)
            new_er_devise_user_session_path
          end
        end
      end
    end
    
  end
end