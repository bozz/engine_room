
module EngineRoom::ViewMethods
  def authorized?(options=nil)
    current_er_devise_user.is_admin?
  end
end

ActionView::Base.send :include, EngineRoom::ViewMethods


 # monkeypatch override Crummy: last breadcrumb should not be a link
module Crummy::ViewMethods
  def render_crumbs_mod(options = {})
    options[:format] = :html if options[:format] == nil
    if options[:seperator] == nil
      options[:seperator] = " &raquo; " if options[:format] == :html
      options[:seperator] = "crumb" if options[:format] == :xml
    end
    options[:links] = true if options[:links] == nil
    case options[:format]
    when :html
      crumb_string = crumbs.collect do |crumb|
        crumb_to_html crumb, crumbs.last==crumb ? false : options[:links]
      end * options[:seperator]
      crumb_string = crumb_string.html_safe if crumb_string.respond_to?(:html_safe)
      crumb_string
    when :xml
      crumbs.collect do |crumb|
        crumb_to_xml crumb, options[:links], options[:seperator]
      end * ''
    else
      raise "Unknown breadcrumb output format"
    end
  end
end

ActionView::Base.send :include, Crummy::ViewMethods

