module EngineRoom
  class ModelsController < ApplicationController
    before_filter :authenticate_er_devise_user!
    
    layout 'engine_room'
    
    unloadable
    
    def overview
      # load all models 
      Dir.glob(Rails.root.to_s + '/app/models/*.rb').each { |file| require file }
      
      # access all loaded models
      # TODO: causes tests to fail !! -- no database
      @models = ActiveRecord::Base.send(:descendants)
    end
    
    
    def index
      @modelname = params[:modelname]
      begin
        @model = get_model(@modelname)
        @elements = @model.find(:all)
      rescue NameError
        @error = "No model with given name was found!"
      end
    end
    
    def show
      @modelname = params[:modelname]
      begin
        @model = get_model(@modelname)
        @element = @model.find(params[:id])
      rescue NameError
        @error = "No model with given name was found!"
      end
    end
    
    def edit
      @modelname = params[:modelname]
      begin
        @model = get_model(@modelname)
        @element = @model.find(params[:id])
      rescue
        @error = "No model with given name was found!"
      end
    end
    
    def update
      @modelname = params[:modelname]
      begin
        @model = get_model(@modelname)
        @element = @model.find(params[:id])
        if @element.update_attributes(params[@modelname.downcase])
          flash[:success] = "#{@modelname} successfully updated."
          redirect_to :action => :edit
        else
          render 'edit'
        end
      rescue
        @error = "No model with given name was found!"
        render 'edit'
      end
    end
    
    private 
    
      def get_model model_name
        model = Object.const_get(model_name.singularize.camelize)
      end
    
  end
end