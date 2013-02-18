class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :require_privileges

  def require_privileges
    unless current_user && current_user.teacher?
      redirect_to root_path
    end
  end

end
