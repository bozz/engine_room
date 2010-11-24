class ValidFieldTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "is not a valid field type.") unless
      Field.field_types.include?(record[attribute])
  end
end

class Field < ActiveRecord::Base
  belongs_to :section
  attr_accessible :column, :field_type, :display_type, :help, :sort_order, :section_id, :overview_link
  serialize :options

  validates :column,       :presence => true
  validates :field_type,   :presence => true, :valid_field_type => true
  validates :display_type, :presence => true
  validates :section_id,   :presence => true
  
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

  def overview_link
    return false if self.options.blank?
    is_link = self.options[:overview_link]
    object_to_boolean(is_link)
  end

  def overview_link=(is_link)
    self.options = Hash.new if self.options.blank?
    self.options[:overview_link] = object_to_boolean(is_link)
  end

  private 

    # TODO: move to more central location - Kernel?
    def object_to_boolean(value)
      return [true, "true", 1, "1", "T", "t"].include?(value.class == String ? value.downcase : value)
    end 

end
