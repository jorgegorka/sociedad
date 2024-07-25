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
    create_users
  end

  def create_users
    @account.users.create! username: 'managerusername', email: 'manager@lasociedad.com', role: User::ADMIN,
                           password: '111111', password_confirmation: '111111'
    @account.users.create! username: 'regularusername', email: 'regular@lasociedad.com', role: User::REGULAR,
                           password: '111111', password_confirmation: '111111'
  end
end
