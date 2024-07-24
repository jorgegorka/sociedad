class AccountsSeed
  class << self
    def create_seed_data
      new.create
    end
  end

  def create
    p 'creating account'
    create_account

    @account
  end

  private

  def create_account
    @account = Account.create!(id: 1, name: 'La sociedad', email: 'manager@lasociedad.com')
    create_manager
  end

  def create_manager
    @account.users.create! username: 'managerusername', email: 'manager@lasociedad.com', role: User::Manager
  end
end
