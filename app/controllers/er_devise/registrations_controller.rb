module ErDevise
  class RegistrationsController < Devise::RegistrationsController
    prepend_view_path(__FILE__ + "../../views")
  end
end