class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  delegate :current_user, :user_signed_in?, to: :user_session
  helper_method :current_user, :user_signed_in? 

  # Run before of any action
  before_action do
  	I18n.locale = params[:locale] 
  end

  # Default to url locale
  def default_url_options
  	{ locale: I18n.locale }
  end

  # Create new instance
  def user_session
  	UserSession.new(session)
  end

  # Check if user is authenticated
  def require_authentication
  	unless user_signed_in?
  		redirect_to new_user_sessions_path, 
  			alert: t('flash.alert.needs_login')
  	end
  end

  # Check if user is already logged in 
  def require_no_authentication
  	if user_signed_in?
  		redirect_to root_path,
  			notice: t('flash.notice.already_logged_in') 
  	end
  end
end