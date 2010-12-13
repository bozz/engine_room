module EngineRoom
  class SectionsController < ApplicationController
    before_filter :authenticate_er_devise_user!
    before_filter :authorize
    before_filter :init_sections

    layout 'engine_room'

    unloadable

    def init_sections
      @sections = Section.order('sort_order ASC')
      @layout = 'columns'
    end

    # GET /section_configs
    def index
      @sections = Section.order('sort_order ASC')
      # index.html.erb
    end

    # GET /section_config/1
    def show
      @section = Section.find(params[:id])
      # show.html.erb
    end

    # GET /section_config/new
    def new
      @section = Section.new
      add_crumb 'Create New Section'
    end

    # GET /section/1/edit
    def edit
      @section = Section.find(params[:id])
      add_crumb(@section.name.titleize, edit_engine_room_section_path(params[:id]))
    end

    # POST /section
    def create
      @section = Section.new(params[:section])
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        redirect_to :action => :index
      else
        add_crumb('Create New Section', new_engine_room_section_path)
        render :action => :new
      end
    end

    # PUT /section/1
    def update
      @section = Section.find(params[:id])
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        redirect_to :action => :index
      else
        add_crumb(@section.name.titleize, edit_engine_room_section_path(params[:id]))
        render :action => :edit
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
