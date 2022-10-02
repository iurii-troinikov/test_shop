# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    false
  end

  def products_index
    false
  end
end
