module Bookings
  class BlockSchedule
    def initialize(user, date, schedule_category_id, full_day: false, blocked_name: nil)
      @user = user
      @account = user.account
      @date = date
      @schedule_category_id = schedule_category_id
      @full_day = full_day
      @blocked_name = blocked_name
    end

    def call
      Booking.transaction do
        if full_day
          account.bookings.where(start_on: date).destroy_all

          booking = user.bookings.create!(
            start_on: date,
            schedule_category_id: nil,
            participants: 0,
            blocked: true,
            full_day: true,
            blocked_name: blocked_name
          )
        else
          account.bookings.where(start_on: date, schedule_category_id: schedule_category_id).destroy_all
          account.bookings.where(start_on: date, full_day: true, blocked: true).destroy_all

          booking = user.bookings.create!(
            start_on: date,
            schedule_category_id: schedule_category_id,
            participants: 0,
            blocked: true,
            blocked_name: blocked_name
          )
        end

        account.resources.each do |resource|
          booking.resource_bookings.create!(resource_id: resource.id)
        end

        booking
      end
    end

    private

      attr_reader :user, :account, :date, :schedule_category_id, :full_day, :blocked_name
  end
end
