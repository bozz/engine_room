module EngineRoom
  class ModelsController < ApplicationController
    before_filter :authenticate_er_devise_user!
    before_filter :check_model_name, :except => [:overview]
    
    layout 'engine_room'
    
    add_crumb "Sections", '/admin/models'
    
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
      @sections = Section.all
    end

    
    def overview2
      @models = []
      missing_models = []
      missing_tables = []
      Section.all.each do |section|
        begin
          model = get_model(section.model_name)
          if model.table_exists?
            @models << model
          else
            missing_tables << section.model_name
          end
        rescue NameError
          missing_models << section.model_name
        end
      end
      
      flash_alert = ""
      flash_alert += "Table(s) not found: '#{missing_tables.uniq.join("', '")}'. " unless missing_tables.empty?
      flash_alert += "Model(s) not found: '#{missing_models.uniq.join("', '")}'." unless missing_models.empty?
      flash[:alert] = flash_alert unless flash_alert.empty?
    end

    
    def index
      @elements = @model.find(:all)
      add_crumb @modelname, {:controller => 'engine_room/models', :action => :index, :modelname => @modelname}
    end
    
    def show
      @element = @model.find(params[:id])
    end
    
    def new
      @element = @model.new
      add_crumb @modelname, {:controller => 'engine_room/models', :action => :index, :modelname => @modelname}
      add_crumb "Create New #{@modelname}"
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