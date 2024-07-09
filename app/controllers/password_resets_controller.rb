class PasswordResetsController < ApplicationController
  def edit
    @token = params[:id]
    @user = User.find_by(forget_token: params[:id])

    return unless @user.blank?

    flash[:alert] = I18n.t('settings.notAuthenticated')
    redirect_to new_session_url
    nil
  end

  def update
    @token = params[:id]
    @user = User.find_by(forget_token: params[:id])
    debugger
    if @user.blank?
      flash[:alert] = I18n.t('settings.notAuthenticated')
      redirect_to new_session_url
      return
    end

    if both_passwords_present && @user.change_password(user_params[:password])
      pp 'hola'
    else
      @no_match = user_params[:password] != params[:user][:password_confirmation]
      @invalid_credentials = true

      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end

  def both_passwords_present
    params[:user][:password].present? && params[:user][:password_confirmation].present?
  end
end
