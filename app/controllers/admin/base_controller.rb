module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_filter :require_priviliges

    def require_privileges
      unless current_user && current_user.teacher?
        redirect_to root_path
      end
    end
    
  end
end
