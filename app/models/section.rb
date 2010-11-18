class Section < ActiveRecord::Base
  has_many :fields
  attr_accessible :model_name, :sort_order
end
