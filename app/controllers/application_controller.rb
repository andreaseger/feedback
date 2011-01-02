class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :user_signed_in?, :current_semester
  before_filter :set_i18n_locale_from_params

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
        " #{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  def default_url_options
    { :locale => I18n.locale }
  end


private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    return true if current_user
    false
  end

  def authenticate!
    redirect_to new_session_url unless user_signed_in?
  end

  def current_semester
    @current_semester ||= Semester.current
  end
end

