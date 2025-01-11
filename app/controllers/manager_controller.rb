class ManagerController < LoggedController
  before_action :is_admin

  private

    def is_admin
      return if Current.user.role == User::ADMIN

      redirect_to dashboard_index_path
      @valid = false
    end
end
