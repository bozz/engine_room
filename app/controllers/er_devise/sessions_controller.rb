module ErDevise
  class SessionsController < Devise::SessionsController
    layout 'login'
    prepend_view_path(__FILE__ + "../../views")
  end
end