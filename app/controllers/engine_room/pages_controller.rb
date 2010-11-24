module EngineRoom
  class PagesController < ApplicationController
    before_filter :authenticate_er_devise_user!
    
    layout 'engine_room'

    unloadable
    
    def dashboard
    end
    
    def sections
      @sections = Section.all
    end
    
  end
end
