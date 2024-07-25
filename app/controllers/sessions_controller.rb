class SessionsController < ApplicationController
  def new
    @invalid_credentials = false
  end

  def create
    @user = User.where('email = :login OR username = :login', { login: params[:login] }).first

    if @user&.authenticate(params[:password]) && @user&.active
      flash[:notice] = t('sessions.welcome')
      Current.user = @user
      Current.account = @user.account
      redirect_to root_path
    else
      @invalid_credentials = true
      Current.user = nil
      Current.account = nil
      render 'new', status: :unprocessable_entity
    end
  end
end
