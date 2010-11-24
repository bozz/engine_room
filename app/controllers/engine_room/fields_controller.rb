module EngineRoom
  class FieldsController < ApplicationController
    before_filter :authenticate_er_devise_user!
    
    layout 'engine_room'
    
    add_crumb "Sections", '/admin/sections'
    
    unloadable
    
    # GET /sections
    def index
      @fields = Field.all
      # index.html.erb
    end

    # GET /fields/1
    def show
      @field = Field.find(params[:id])
      # show.html.erb
    end

    # GET /fields/new
    def new
      @field = Field.new
      @section = Section.find(params[:section_id])
      
      add_crumb(@section.name, edit_engine_room_section_path(@section.id))
      add_crumb 'New Field'
    end

    # GET /fields/1/edit
    def edit
      @field = Field.find(params[:id])
      @section = Section.find(params[:section_id])
      
      add_crumb(@section.name, edit_engine_room_section_path(@section.id))
      add_crumb('Edit Field', edit_engine_room_section_field_path(@section, @field.id))
    end

    # POST /fields
    def create
      @field = Field.new(params[:field])
      @section = Section.find(params[:section_id])
      if @field.save
        flash[:notice] = 'Field was successfully created.'
        redirect_to edit_engine_room_section_url(@section.id)
      else
        render :action => "new"
      end
    end

    # PUT /fields/1
    def update
      @field = Field.find(params[:id])
      @section = Section.find(params[:section_id])
      if @field.update_attributes(params[:field])
        flash[:notice] = 'Field was successfully updated.'
        redirect_to edit_engine_room_section_url(@section.id)
      else
        render :action => "edit"
      end
    end

    # DELETE /fields/1
    def destroy
      @field = Field.find(params[:id])
      @field.destroy

      flash[:notice] = 'Field was successfully deleted.'
      
      section_id = params[:section_id]
      redirect_to edit_engine_room_section_url(section_id)
    end
    
  end
end