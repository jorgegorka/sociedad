return if Rails.env.production?

require_relative 'seeds/accounts_seed'
require_relative 'seeds/schedule_categories_seed'

account = AccountsSeed.create_seed_data
ScheduleCategoriesSeed.create_seed_data(account)
