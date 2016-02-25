class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def user_page
    @user_page = User.find(params[:id])
  end
  helper_method :user_page
  # Simply store our ID in the session
  # and set the current user instance var
  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end
  # reverse the sign in...
  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
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
      flash[:error] = 'Not authorized, please sign in!'
      redirect_to root_url  #< Remember this is a custom route
    end
  end

  def require_current_user
    # don't forget that params is a string!!!
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      if request.referrer.nil?
        redirect_to user_timeline_path(current_user)
      else
        redirect_to request.referrer
      end
    end
  end

  def get_user
    User.find(params[:id].to_i)
  end
  helper_method :get_user
end
