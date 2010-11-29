module EngineRoom
  class ContentController < ApplicationController
    before_filter :authenticate_er_devise_user!
    
    layout 'engine_room'

    add_crumb "Content", '/admin/content'
    before_filter :init_section, :except => [:overview]

    helper_method :sort_column, :sort_direction

    unloadable
    
    def init_section
      @section = Section.find_by_name(params[:section_name])
      if @section.nil?
        flash[:alert] = "No section named #{params[:section_name]} was found."
        redirect_to :action => :overview
      else
        @model = get_model(@section.model_name) # TODO: catch exception
        add_crumb @section.name.titleize, {:controller => 'engine_room/content', :action => :index}
      end
    end

    def overview
      @sections = Section.all
    end

    def index 
      @elements = @model.order(sort_column + " " + sort_direction).paginate :page => params[:page], :per_page => 20
    end
    
    def new
      @element = @model.new
      add_crumb "New #{@section.model_name.humanize}"
    end

    def create
      @element = @model.new(params[@section.model_name])
      if @element.save
        flash[:notice] = "#{@section.model_name.humanize} was successfully created."
        redirect_to :action => :index
      else
        add_crumb "New #{@section.model_name.humanize}"
        render :action => "new"
      end
    end

    def edit
      @element = @model.find(params[:id])
      add_crumb "Edit #{@section.model_name.humanize}"
    end

    def update
      @element = @model.find(params[:id])
      if @element.update_attributes(params[@section.model_name])
        flash[:notice] = "#{@section.model_name.humanize} was successfully updated."
        redirect_to :action => :index
      else
        add_crumb "Edit #{@section.model_name.humanize}"
        render :action => "edit"
      end
    end

    def destroy
      @element = @model.find(params[:id])
      @element.destroy

      flash[:notice] = "#{@section.model_name.humanize} was successfully deleted."
      redirect_to :action => :index
    end

    private

      def get_model model_name
        model = Object.const_get(model_name.singularize.camelize)
      end

      def sort_column
        #params[:sort] || "id"
        @model.column_names.include?(params[:sort]) ? params[:sort] : "id"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end
  end
end
