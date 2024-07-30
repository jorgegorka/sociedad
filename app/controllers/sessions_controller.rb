class SessionsController < ApplicationController
  def new
    @invalid_credentials = false
  end

  def create
    @user = User.where("email = :login OR username = :login", { login: params[:login] }).first

    if @user&.authenticate(params[:password]) && @user&.active
      flash[:notice] = t("sessions.welcome")
      Current.user = @user
      Current.account = @user.account
      session[:user_id] = @user.id

      redirect_to root_path
    else
      @invalid_credentials = true
      Current.user = nil
      Current.account = nil

      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    Current.user = nil
    Current.account = nil
    session[:user_id] = nil

    redirect_to login_path
  end
end
