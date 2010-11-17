module ErDevise
  class PasswordsController < Devise::PasswordsController
    layout 'login'
    prepend_view_path(__FILE__ + "../../views")
  end
end