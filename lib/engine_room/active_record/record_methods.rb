module EngineRoom::RecordMethods

  #def self.included(base)
  #  base.module_eval do
  #    helper_attr :current_user
  #  end
  #end

  #def current_user
  #  current_er_devise_user
  #end

  def object_to_boolean(value)
    return [true, "true", 1, "1", "T", "t"].include?(value.class == String ? value.downcase : value)
  end 
end

ActiveRecord::Base.send :include, EngineRoom::RecordMethods
