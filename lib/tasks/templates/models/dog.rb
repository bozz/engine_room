class Dog < ActiveRecord::Base
  validates :name, :presence => true 
end
