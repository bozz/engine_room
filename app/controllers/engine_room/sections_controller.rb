module EngineRoom
  class SectionsController < ApplicationController
    before_filter :authenticate_er_devise_user!
    
    layout 'engine_room'
    
    unloadable
    
    #def overview
      # load all models 
      #Dir.glob(Rails.root.to_s + '/app/models/*.rb').each { |file| require file }
      
      # access all loaded models
      # TODO: causes tests to fail !! -- no database
      #@models = ActiveRecord::Base.send(:descendants)
    #end
    
    # GET /sections
    def index
      @sections = Section.all
      # index.html.erb
    end

    # GET /section/1
    def show
      @section = Section.find(params[:id])
      # show.html.erb
    end

    # GET /posts/new
    def new
      @section = Section.new
      # new.html.erb
    end

    # GET /section/1/edit
    def edit
      @section = Section.find(params[:id])
    end

    # POST /section
    def create
      @section = Section.new(params[:section])
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        redirect_to :action => :index
      else
        render :action => "new"
      end
    end

    # PUT /section/1
    def update
      
      puts p(params)
      
      @section = Section.find(params[:id])
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        redirect_to :action => :index
      else
        render :action => "edit"
      end
    end

    # DELETE /section/1
    def destroy
      @section = Section.find(params[:id])
      @section.destroy

      flash[:notice] = 'Section was successfully deleted.'
      redirect_to :action => :index
    end
    
  end
end