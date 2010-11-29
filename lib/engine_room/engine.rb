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
