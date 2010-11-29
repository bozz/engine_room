class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :last_sign_in_at, :is_admin


  def is_admin?
    self.is_admin==1 ? true : false
  end


  def update_with_admin_check(user_params, is_admin=false)
    if is_admin
      self.update_attributes(user_params)
    else
      self.update_with_password(user_params)
    end
  end


  # MonkeyPatch of Devise method in devise/lib/devise/models/validatable.rb
  # to enable updating user without specifying password
  def password_required?
    !persisted?  || !password.blank? # || !password_confirmation.nil?
  end

end
