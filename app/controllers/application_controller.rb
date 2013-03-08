class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_menu_location
  before_filter :authenticate_user!
  before_filter :set_locale
  
    def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.teacher?
      flash[:alert] = "Ocupas ser maestro para entrar"
      redirect_to root_path
    end
  end
  
  def set_menu_location
    @menu = 'devise/menu/login_items'
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    params[:locale] = I18n.locale.to_s
  end

 def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
 end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_dashboard_path, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
