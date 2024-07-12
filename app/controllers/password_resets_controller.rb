class PasswordResetsController < ApplicationController
  def edit
    @token = params[:id]
    @user = User.validate_reset_values params[:id]

    return unless @user.blank?

    redirect_to '',
                notice: I18n.t('resetPassword.invalidResetValues')
  end

  def update
    @token = params[:id]
    @user = User.validate_reset_values params[:id]

    if @user.blank?
      redirect_to '',
                  notice: I18n.t('resetPassword.invalidResetValues')
    end

    if @user.update(password: user_params[:password], password_confirmation: params[:user][:password_confirmation])
      redirect_to '/', notice: t('resetPassword.passwordUpdated')
      @user.delete_reset_values
    else
      @invalid_credentials = true

      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def both_passwords_present
    params[:user][:password].present? && params[:user][:password_confirmation].present?
  end
end
