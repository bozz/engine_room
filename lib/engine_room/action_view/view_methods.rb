
module EngineRoom::ViewMethods
  def authorized?(options=nil)
    current_er_devise_user.is_admin?
  end
end

ActionView::Base.send :include, EngineRoom::ViewMethods
