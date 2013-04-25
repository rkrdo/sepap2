module ApplicationHelper

  def admin_stylesheets
    stylesheet_link_tag "admin_overrides" if params[:controller] =~ /admin\/*/
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
