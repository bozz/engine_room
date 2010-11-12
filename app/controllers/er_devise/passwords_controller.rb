module ErDevise
  class PasswordsController < Devise::PasswordsController
    prepend_view_path(__FILE__ + "../../views")
  end
end