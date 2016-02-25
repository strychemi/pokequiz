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

  # Will turn the current_user into a boolean
  # e.g. `nil` becomes false and anything else true.
  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:error] = 'Unauthorized, please sign in'
      redirect_to login_path
    end
  end

  def require_current_user
    unless (params[:id] == current_user.id.to_s) || (params[:user_id] == current_user.id.to_s)
      flash[:error] = "You're not authorized to view this"
      redirect_to request.referrer || root_path
    end
  end
end
