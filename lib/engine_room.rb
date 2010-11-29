module EngineRoom
  require 'engine_room/engine' if defined?(Rails)
  require 'devise' if defined?(Rails)

  require 'engine_room/action_controller/controller_methods'
  require 'engine_room/action_view/view_methods'
end
