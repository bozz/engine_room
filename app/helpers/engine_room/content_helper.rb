module EngineRoom
  module ContentHelper

    def sortable(column)
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to column.titleize, {:sort => column, :direction => direction}, {:class => css_class}
    end


    def field_to_overview(field, element, section, bt_section_name=nil, bt_id=nil)
      html = element[field.column]
      if html.class.name == "Time"
        html = l( html, :format => :short )
      end

      case field.field_type
        when "paperclip_field"
          img_name = element["#{field.column}_file_name"]
          html = image_tag( element.send( field.column ).url, :title => img_name, :height => "50px" )
      end

      if field.overview_link
        link_options = {:controller => 'engine_room/content', :section_name => section.name, :id => element.id, :action => :edit}
        if bt_section_name && bt_id
          link_options[:bt_section] = bt_section_name
          link_options[:bt_id] = bt_id
        end
        html = link_to html, link_options
      end
      return content_tag(:td, html, nil, false)
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
        when "belongs_to"
          html += form.select field.column, options_for_belongs_to(field, element)
        when "paperclip_field"
          if element.respond_to?("#{field.column}_file_name")
            img_name = element["#{field.column}_file_name"]
            html += image_tag( element.send( field.column ).url, :title => img_name, :height => "50px" )
            html += content_tag(:p, "file name: #{img_name}")
          end
          html += form.file_field field.column
      end

      unless field.help.blank?
        html += content_tag(:i, field.help)
      end

      return content_tag(:div, html, :class => "field")
    end

    # get all elements that element has_many of (paginated)
    def has_many_elements(element, target_model)
      element.class.reflect_on_all_associations(:has_many).each do |assoc|
        if assoc.name.to_s == target_model.downcase.pluralize
          model = Object.const_get(target_model.singularize.camelize)
          return element.send(target_model.downcase.pluralize).paginate(:per_page => 10, :page => 1)
        end
      end
      return []
    end

    private

      def options_for_belongs_to(field, element)

        target_class_name = field.column.match(/(.*)_id$/) ? $1 : ""

        element.class.reflect_on_all_associations(:belongs_to).each do |assoc|
          if assoc.name.to_s == target_class_name
            model = Object.const_get(target_class_name.singularize.camelize)
            return options_for_select(model.order("#{field.target_display_column}").collect {|r| [r[field.target_display_column], r.id] }, element[field.column])
          end
        end

        return options_for_select([])
      end

  end
end
