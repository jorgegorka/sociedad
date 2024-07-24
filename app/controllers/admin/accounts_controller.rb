class Admin::AccountsController < AdminController
  before_action :find_account, only: %i[edit update destroy]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    if Accounts::NewAccount.new(params).call
      notice = t('admin.accounts.created')
      redirect_to admin_accounts_path, notice:
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @account.update(account_params)
      notice = t('admin.accounts.updated')
      redirect_to admin_accounts_path, notice:
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @account.destroy

    notice = t('admin.accounts.deleted')

    redirect_to admin_accounts_path, notice:
  end

  private

  def find_account
    @account = Account.find params[:id]
  end
end
