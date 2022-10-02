class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order

  def current_order
    Order.find_or_initialize_by(id: session[:order_id], status: Order.statuses[:in_progress], user: current_user)
  end

  def authenticate_admin!
    redirect_to new_user_session_path if current_user.nil?
    redirect_to root_path unless current_user.role_admin?
  end

  private
  def user_not_authorized
    flash[:error] = "Not authorized"
    redirect_to root_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
