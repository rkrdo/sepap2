class Admin::BaseController < ApplicationController
  before_filter :require_privileges
  before_filter :set_menu_location
  
  def set_menu_location
    @menu = 'devise/menu/admin_items'
  end

  def require_privileges
    unless current_user && current_user.teacher?
      redirect_to root_path
    end
  end

end
