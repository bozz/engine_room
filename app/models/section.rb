class ValidModelValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "is not a valid model.") unless
      Section.valid_model_name?(record[attribute])
  end
end

class Section < ActiveRecord::Base
  has_many :fields, :dependent => :destroy
  attr_accessible :name, :model_name, :sort_order

  validates :name,        :presence => true
  validates :model_name,  :presence => true, :valid_model => true

  default_scope :order => 'sections.sort_order ASC'

  # returns array of model names found in app/models/
  def self.model_names
    Dir.glob(Rails.root.to_s + '/app/models/*.rb').collect { |file| File.basename(file, '.*') }
  end

  # check if given model name matches existing model
  def self.valid_model_name?(name)
    !name.blank? && self.model_names.include?(name.downcase)
  end

  def name=(name_string)
    write_attribute(:name, name_string.gsub(/ /, "_").underscore)
  end

  # returns model corresponding to model_name, or nil if not found
  def model
    begin
      return Object.const_get(model_name.singularize.camelize)
    rescue NameError
      return nil
    end
  end

  def detail_fields
    self.fields.where(:display_type => 'detail')
  end

  def has_many_fields
    self.fields.where(:display_type => 'has_many')
  end

  def overview_fields
    self.fields.where(:display_type => 'overview')
  end

  # returns array of valid column names of associated model
  def column_names
    model.column_names
  end
end
