class ValidFieldTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "is not a valid field type.") unless
      Field.field_types.include?(record[attribute])
  end
end

class Field < ActiveRecord::Base
  belongs_to :section
  attr_accessible :column, :field_type, :sort_order, :section_id
  
  validates :column,      :presence => true
  validates :field_type,  :presence => true, :valid_field_type => true
  validates :section_id,  :presence => true
  
  default_scope :order => 'fields.sort_order ASC'

  # returns array of possible field types
  def self.field_types
    return [
      'hidden',
      'read_only',
      'text_field',
      'email_field',
      'number_field',
      'text_area',
      'boolean',
      'enum'
    ]
  end
  
end
