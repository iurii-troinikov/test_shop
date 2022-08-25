class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_order
  helper_method :current_user
  def current_order
    Order.find_or_create_by(user: current_user, status: 'in_progress')
  end

  def current_user
    User.first
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ])
  end
end
