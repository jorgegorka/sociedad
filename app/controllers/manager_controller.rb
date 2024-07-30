class ManagerController < LoggedController
  before_action :is_admin

  private

    def is_admin
      return if Current.user.role == User::ADMIN

      @valid = false
    end
end
