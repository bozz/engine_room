class ValidModelValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "is not a valid model.") unless
      Section.valid_model_name?(record[attribute])
  end
end

class Section < ActiveRecord::Base
  has_many :fields
  attr_accessible :model_name, :sort_order
  
  validates :model_name,  :presence => true, :valid_model => true
  

  # returns array of model names found in app/models/
  def self.model_names
    Dir.glob(Rails.root.to_s + '/app/models/*.rb').collect { |file| File.basename(file, '.*') }
  end
  
  # check if given model name matches existing model
  def self.valid_model_name?(name)
    !name.blank? && self.model_names.include?(name.downcase)
  end
end
