class AdminController < ApplicationController
  before_action :is_superadmin

  private

  def is_superadmin
    return if Current.user.role == User::SUPERADMIN

    @valid = false
  end
end
