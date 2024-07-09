module Accounts
  class NewAccount
    def initialize(params)
      @account_name = params[:account_name]
      @user_name = params[:user_name]
      @email = params[:email]
    end

    def call
      account = Account.create(name: account_name, email:)

      if account.persisted?
        user = account.users.create(username: user_name, email:, password: SecureRandom.hex(24))
        user.assign_forget_attributes
        NewAccountMailer.notify_user(user.id).deliver_later
        true
      else
        false
      end
    end

    private

    attr_reader :account_name, :user_name, :email
  end
end
