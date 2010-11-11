module EngineRoom
  class PagesController < ApplicationController
    layout 'engine_room'
    
    unloadable
    
    #layout 'engineroom'  # this allows you to have a gem-wide layout
    
    def dashboard
    end
    
  end
end