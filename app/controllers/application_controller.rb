class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized"
    redirect_to(request.referrer || root_path)
  end
end
