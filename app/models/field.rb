class Field < ActiveRecord::Base
  belongs_to :section
  attr_accessible :column, :type, :sort_order
end
