module Bookings
  class CurrentInfo
    def initialize(account, start_on, schedule_category_id)
      @account = account
      @start_on = start_on
      @schedule_category_id = schedule_category_id
    end

    def call
      @num_bookings = 0
      @participants = 0
      @blocked = false
      @day_blocked = false
      @blocked_name = nil

      @day_blocked = account.bookings.full_day_blocked_for(start_on).exists?
      if @day_blocked
        blocked_booking = account.bookings.full_day_blocked_for(start_on).first
        @blocked_name = blocked_booking.blocked_name
      end

      @schedule_name = account.schedule_categories.find_by(id: schedule_category_id)&.name

      bookings = account.bookings.where(start_on:, schedule_category_id:)
      bookings.each do |booking|
        @num_bookings += 1
        @participants += booking.participants
        @blocked = true if booking.blocked?
      end

      { num_bookings: @num_bookings, participants: @participants, schedule_name: @schedule_name, blocked: @blocked, day_blocked: @day_blocked, blocked_name: @blocked_name }
    end

    private

      attr_reader :account, :schedule_category_id, :start_on
  end
end
