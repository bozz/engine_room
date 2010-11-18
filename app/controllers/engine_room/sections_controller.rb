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
        redirect_to(@section, :notice => 'Section was successfully created.')
      else
        render :action => "new"
      end
    end

    # PUT /section/1
    def update
      @section = Section.find(params[:id])
      if @section.update_attributes(params[:section])
        redirect_to(@section, :notice => 'Section was successfully updated.')
      else
        render :action => "edit"
      end
    end

    # DELETE /section/1
    def destroy
      @section = Section.find(params[:id])
      @section.destroy

      redirect_to(posts_url)
    end
    
  end
end