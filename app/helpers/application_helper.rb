module ApplicationHelper

  def admin_stylesheets
    stylesheet_link_tag "admin_overrides" if params[:controller] =~ /admin\/*/
  end
end
