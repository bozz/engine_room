module ErDevise
  class SessionsController < Devise::SessionsController
    prepend_view_path(__FILE__ + "../../views")
  end
end