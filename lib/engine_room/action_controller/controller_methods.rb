module EngineRoom::ControllerMethods

  def self.included(base)
    base.module_eval do
      helper_attr :current_user
    end
  end

  def current_user
    current_er_devise_user
  end

  def authorize
    unless current_er_devise_user.is_admin?
      flash[:alert] = "Access denied"
      redirect_to engine_room_root_url
    end
  end
end

ActionController::Base.send :include, EngineRoom::ControllerMethods


require 'crummy'
ActionController::Base.send :include, Crummy::ControllerMethods

