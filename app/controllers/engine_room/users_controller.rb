module EngineRoom
  class UsersController < ApplicationController
    before_filter :authenticate_er_devise_user!
    before_filter :authorize, :except => [:edit_current_user, :update_current_user, :destroy_current_user]

    layout 'engine_room'

    add_crumb "Users", '/admin/users'

    unloadable

    # GET /users
    def index
      @users = User.order('username ASC')
      # index.html.erb
    end

    def new
      @user = User.new
      add_crumb("Create User")
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = 'User was successfully created.'
        redirect_to :action => :index
      else
        @user.clean_up_passwords
        add_crumb("Create User")
        render :action => :new
      end
    end

    def edit
      @user = User.find(params[:id])
      add_crumb("Edit User")
    end

    def edit_current_user
      @user = current_user
      render :edit
    end

    def update
      @user = User.find(params[:id])
      update_user
    end

    def update_current_user
      @user = current_user
      update_user
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      flash[:notice] = 'User was successfully deleted.'
      redirect_to :action => :index
    end

    def destroy_current_user
      @user = current_user
      @user.destroy

      redirect_to destroy_er_devise_user_session_url
    end

    private

      def update_user
        if @user.update_with_admin_check(params[:user], current_user.is_admin?)
          flash[:notice] = 'User was successfully updated.'
          redirect_to :action => params[:action]=="update" ? :index : :edit_current_user
        else
          @user.clean_up_passwords
          add_crumb("Edit User")
          render :action => :edit
        end
      end

  end
end
