class SessionsController < ApplicationController
  def new
    @invalid_credentials = false
  end

  def create
    @user = User.find_by('email = :login OR username = :login', { login: params[:login] })

    if @user&.authenticate(params[:password])
      flash[:notice] = t('sessions.welcome')
      Current.user = @user
      Current.account = @user.account

    else
      @invalid_credentials = true
      Current.user = nil
      Current.account = nil
      render 'new', status: :unprocessable_entity
    end
  end
end
