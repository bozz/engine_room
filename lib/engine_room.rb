module EngineRoom

  if defined? Rails
    require 'engine_room/engine'

    require 'devise'
    require 'will_paginate'
    require 'paperclip'
    require 'crummy'

    require 'engine_room/action_controller/controller_methods'
    require 'engine_room/action_view/view_methods'
  end
end
