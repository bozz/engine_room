module ErDevise
  class RegistrationsController < Devise::RegistrationsController
    before_filter :authenticate_er_devise_user!
    layout 'engine_room'
    prepend_view_path(__FILE__ + "../../views")

  end
end
