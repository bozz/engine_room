class ValidFieldTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "is not a valid field type.") unless
      Field.field_types.include?(record[attribute])
  end
end

class Field < ActiveRecord::Base
  belongs_to :section
  attr_accessible :column, :field_type, :display_type, :help, :sort_order, :section_id, :overview_link #, :display_target_column
  serialize :options

  validates :column,       :presence => true
  validates :field_type,   :presence => true, :valid_field_type => true
  validates :display_type, :presence => true
  validates :section_id,   :presence => true

  default_scope :order => 'fields.sort_order ASC'

  @@field_config = {
    'hidden' => [],
    'read_only' => [],
    'text_field' => [],
    'email_field' => [],
    'number_field' => [],
    'date_field' => ['format'],
    'text_area' => [],
    'boolean' => [],
    'enum' => ['enum_values'],
    'paperclip_field' => [],
    'belongs_to' => ['target_display_column'],
    'has_many' => ['target_model', 'target_section_id']
  }

  # returns array of possible field types
  def self.field_types
    @@field_config.keys
  end

  def option_fields
    self.field_type.blank? || !@@field_config.has_key?(self.field_type) ? [] : @@field_config[self.field_type] 
  end

  def self.valid_options
    options = []
    @@field_config.each_value do |val|
      options.concat(val)
    end
    return options
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

    # overriding for dynamic attr_accessible access to options
    def mass_assignment_authorizer
      super + Field.valid_options
    end

    def self.define_all_options
      valid_options.each { |opt| define_option(opt) }
    end

    def self.define_option(name)
      define_method(name) do
        return false if self.options.blank?
        self.options[name]
      end
      define_method("#{name}=") do |val|
        self.options = Hash.new if self.options.blank?
        self.options[name] = val
      end
    end

    define_all_options

end
