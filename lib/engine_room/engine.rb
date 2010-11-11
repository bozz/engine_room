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
  end
end