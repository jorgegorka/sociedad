class LoggedController < ApplicationController
  before_action :authenticate_user!

  private

    def authenticate_user!
      user = User.find session[:user_id]
      Current.user = user
      Current.account = user.account
    end
end
