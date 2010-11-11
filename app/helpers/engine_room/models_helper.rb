module EngineRoom
  module ModelsHelper
  
    def get_form_field_for_column(form, element, column)

      if column.primary || column.name == "created_at" || column.name == "updated_at"
        element[column.name]
      else 
        
        if [:string, :integer, :datetime].include?(column.type)
          form.text_field column.name
        elsif [:text].include?(column.type)
          form.text_area column.name, :class => "bespind", :rows => 5
        else
          column.type
        end
      end
    end
  
  end
end
