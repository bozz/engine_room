module EngineRoom

  if defined? Rails
    #Dir.glob(Rails.root.to_s + '/app/models/*.rb').each { |file| require file }

    require 'engine_room/engine'

    require 'devise'
    require 'will_paginate'
    require 'paperclip'
    require 'crummy'

    require 'engine_room/action_controller/controller_methods'
    require 'engine_room/action_view/view_methods'
    require 'engine_room/active_record/record_methods'
  end
end
