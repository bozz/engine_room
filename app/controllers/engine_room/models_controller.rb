module EngineRoom
  class ModelsController < ApplicationController
    before_filter :authenticate_er_devise_user!
    before_filter :check_model_name, :except => [:overview]
    
    layout 'engine_room'
    
    unloadable
    
    def check_model_name
      @modelname = params[:modelname]
      begin
        @model = get_model(@modelname)
      rescue NameError
        flash[:error] = "No model with given name was found!"
        redirect_to :action => :overview
      end
    end
    
    
    def overview
      @models = []
      Section.all.each do |section|
        begin
          @models << get_model(section.model_name)
        rescue NameError
          # ignore errors
        end
      end
    end

    
    def index
      @elements = @model.find(:all)
    end
    
    def show
      @element = @model.find(params[:id])
    end
    
    def edit
      @element = @model.find(params[:id])
    end
    
    def update
      @element = @model.find(params[:id])
      if @element.update_attributes(params[@modelname.downcase])
        flash[:notice] = "#{@modelname} successfully updated."
        redirect_to :action => :edit
      else
        render 'edit'
      end
    end
    
    private 
    
      def get_model model_name
        model = Object.const_get(model_name.singularize.camelize)
      end
    
  end
end