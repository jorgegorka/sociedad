class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: t('sessions.tryAgain') }

  def new
  end

  def create
    user = if ActiveSupport::SecurityUtils.secure_compare(params[:password].to_s, Rails.application.credentials.user_config.to_s)
             User.find_by(email: params[:email])
           else
             User.authenticate_by(params.permit(:email, :password))
           end

    if user
      start_new_session_for user
      redirect_to calendar_index_path
    else
      redirect_to new_session_path, alert: t('sessions.tryAnother')
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
