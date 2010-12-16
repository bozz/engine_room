module EngineRoom
  class Engine < Rails::Engine

    config.mount_at = '/admin'
    config.locale = 'en'

  end
end
