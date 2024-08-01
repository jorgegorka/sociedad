class BookingsSeed
  class << self
    def create_seed_data(account)
      new(account).create_seed_data
    end
  end

  def initialize(account)
    @account = account
  end

  def create_seed_data
    p 'creating bookings'
    add_bookings
  end

  private

    attr_reader :account

    def add_bookings
      user = account.users.first
      schedule_category = account.schedule_categories.first
      schedule_category1 = account.schedule_categories.last

      user.bookings.create!(
        start_on: Date.today,
        schedule_category:
      )
      user.bookings.create!(
        start_on: Date.today + 2,
        schedule_category: schedule_category1
      )
      user.bookings.create!(
        start_on: Date.today + 2,
        schedule_category:
      )
      user.bookings.create!(
        start_on: Date.today + 4,
        schedule_category: schedule_category1
      )
      user.bookings.create!(
        start_on: Date.today + 7,
        schedule_category:
      )
      user.bookings.create!(
        start_on: Date.today + 15,
        schedule_category: schedule_category1
      )
      user.bookings.create!(
        start_on: Date.today + 20,
        schedule_category: schedule_category1
      )
      user.bookings.create!(
        start_on: Date.today + 33,
        schedule_category:
      )
    end
end
