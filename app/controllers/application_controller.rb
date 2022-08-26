class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :current_order

  def current_order
    Order.find_or_create_by(user: current_user, status: Order.statuses[:in_progress])
  end

  def authenticate_admin!
    redirect_to new_user_session_path if current_user.nil?
    redirect_to root_path unless current_user.role_admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
