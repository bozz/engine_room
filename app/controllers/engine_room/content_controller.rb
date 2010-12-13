module EngineRoom
  class ContentController < ApplicationController
    before_filter :authenticate_er_devise_user!
    before_filter :init_section, :except => [:overview]

    layout 'engine_room'

    helper_method :sort_column, :sort_direction

    unloadable

    def init_section
      @sections = Section.all
      @layout = 'columns'
      @section = Section.find_by_name(params[:section_name])
      if @section.nil?
        flash[:alert] = "No section named #{params[:section_name]} was found."
        redirect_to :action => :overview
      else
        @model = get_model(@section.model_name) # TODO: catch exception
        if params[:bt_section] && params[:bt_id]
          bt_section = Section.find_by_name(params[:bt_section])
          if params.has_key?(@section.model_name) && @section.name != bt_section.name
            # setup foreign key for has_many relationships
            params[@section.model_name]["#{bt_section.model_name.singularize}_id"] = params[:bt_id]
          end
          add_crumb bt_section.name.titleize, {:controller => 'engine_room/content', :section_name => bt_section.name, :action => :index}
          add_crumb params[:bt_id], {:controller => 'engine_room/content', :section_name => bt_section.name, :id => params[:bt_id], :action => :edit}
        else
          add_crumb @section.name.titleize, {:controller => 'engine_room/content', :action => :index}
        end
      end
    end

    def overview
      @sections = Section.all
      @layout = 'columns'
    end

    def index
      if @section.view_type == 'detail'
        @element = @model.where(@section.condition).first
        if @element
          render :action => :edit
        else
          flash[:alert] = "No matching item could be found for section \"#{@section.name.titleize}\"."
          redirect_to :action => :overview
        end
      else
        @elements = @model.order(sort_column + " " + sort_direction).paginate :page => params[:page], :per_page => 20
      end
    end

    def new
      @element = @model.new
      add_crumb "New #{@section.model_name.humanize}"
    end

    def create
      @element = @model.new(params[@section.model_name])
      if @element.save
        flash[:notice] = "#{@section.model_name.humanize} was successfully created."
        redirect_to_or_back :action => :index
      else
        add_crumb "New #{@section.model_name.humanize}"
        render :action => :new
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
        redirect_to_or_back :action => :index
      else
        add_crumb "Edit #{@section.model_name.humanize}"
        render :action => :edit
      end
    end

    def destroy
      @element = @model.find(params[:id])
      @element.destroy

      flash[:notice] = "#{@section.model_name.humanize} was successfully deleted."
      redirect_to_or_back :action => :index
    end

    private

      def redirect_to_or_back options
        if params[:bt_section] && params[:bt_id]
          redirect_to :action => :edit, :section_name => params[:bt_section], :id => params[:bt_id]
        else
          redirect_to options
        end
      end

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
