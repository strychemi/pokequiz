class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
    @current_user == user && cookies[:auth_token] == user.auth_token
    logger.debug "User #{user.profile.full_name} has signed in."
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
    @current_user == user && cookies[:auth_token] == user.auth_token
  end

  def sign_out
    @current_user = nil
    cookies.permanent[:auth_token] = cookies[:auth_token] = nil
    @current_user.nil? && cookies[:auth_token].nil?
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:danger] = 'Unauthorized, please sign in'
      redirect_to root_path
      logger.debug "Someone tried to access a page that required a login"
    end
  end

  def require_logout
    redirect_to user_path(current_user) if signed_in_user?
  end

  def require_current_user
    unless (params[:id] == current_user.id.to_s) || (params[:user_id] == current_user.id.to_s)
      flash[:danger] = "You're not authorized"
      redirect_to request.referrer || root_path
      logger.debug "Someone tried to access a page that required the current user"
    end
  end
end
