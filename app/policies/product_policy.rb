# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def fetch_products?
    user.present? && user.role_admin?
  end
end
