module EngineRoom
  module ContentHelper
  
    def sortable(column)
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to column.titleize, {:sort => column, :direction => direction}, {:class => css_class}
    end

    def field_to_form(field, element, form)

      html = form.label field.column, field.column.humanize

      case field.field_type
        when "hidden"
          html += form.hidden_field field.column 
        when "read_only"
          html += element[field.column]
        when "text_field"
          html += form.text_field field.column
        when "email_field"
          html += form.text_field field.column
        when "number_field"
          html += form.number_field field.column
        when "date_field"
          html += form.date_select field.column
        when "text_area"
          html += form.text_area field.column, :rows => 4
        when "boolean"
          html += form.check_box field.column
        when "enum"
          html += form.select field.column
      end 
      
      unless field.help.blank?
        html += content_tag(:i, field.help)
      end

      return content_tag(:div, html, :class => "field")
    end
  
  end
end
