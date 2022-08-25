class ApplicationController < ActionController::Base
  helper_method :current_order
  helper_method :current_user

  def current_order
    Order.find_or_create_by(user: current_user, status: 'in_progress')
  end

  def current_user
    User.first
  end
end
