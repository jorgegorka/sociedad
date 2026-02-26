require "test_helper"

class Bookings::BlockScheduleTest < ActiveSupport::TestCase
  test "creates a blocked booking" do
    date = Date.current + 20.days
    booking = Bookings::BlockSchedule.new(admin, date, schedule_category.id).call

    assert booking.persisted?
    assert booking.blocked?
    assert_equal 0, booking.participants
    assert_equal admin, booking.user
  end

  test "assigns all account resources" do
    date = Date.current + 20.days
    booking = Bookings::BlockSchedule.new(admin, date, schedule_category.id).call

    assert_equal account.resources.count, booking.resource_bookings.count
  end

  test "destroys existing bookings for that date and schedule" do
    date = Date.current + 20.days
    sc_id = schedule_category.id

    Booking.insert_all([
      { user_id: admin.id, schedule_category_id: sc_id, start_on: date, end_on: date, participants: 5 },
      { user_id: regular.id, schedule_category_id: sc_id, start_on: date, end_on: date, participants: 3 }
    ])

    assert_equal 2, account.bookings.where(start_on: date, schedule_category_id: sc_id).count

    Bookings::BlockSchedule.new(admin, date, sc_id).call

    remaining = account.bookings.where(start_on: date, schedule_category_id: sc_id)
    assert_equal 1, remaining.count
    assert remaining.first.blocked?
  end

  test "creates a full day blocked booking" do
    date = Date.current + 20.days
    booking = Bookings::BlockSchedule.new(admin, date, nil, full_day: true, blocked_name: "Cena de socios").call

    assert booking.persisted?
    assert booking.blocked?
    assert booking.full_day?
    assert_nil booking.schedule_category_id
    assert_equal "Cena de socios", booking.blocked_name
  end

  test "full day block destroys all bookings for the day" do
    date = Date.current + 20.days
    sc_id = schedule_category.id
    sc2_id = schedule_categories(:schedule_category2).id

    Booking.insert_all([
      { user_id: admin.id, schedule_category_id: sc_id, start_on: date, end_on: date, participants: 5 },
      { user_id: regular.id, schedule_category_id: sc2_id, start_on: date, end_on: date, participants: 3 }
    ])

    assert_equal 2, account.bookings.where(start_on: date).count

    Bookings::BlockSchedule.new(admin, date, nil, full_day: true).call

    remaining = account.bookings.where(start_on: date)
    assert_equal 1, remaining.count
    assert remaining.first.blocked?
    assert remaining.first.full_day?
  end

  test "full day block assigns all resources" do
    date = Date.current + 20.days
    booking = Bookings::BlockSchedule.new(admin, date, nil, full_day: true).call

    assert_equal account.resources.count, booking.resource_bookings.count
  end

  test "schedule block removes existing full day block" do
    date = Date.current + 20.days

    Bookings::BlockSchedule.new(admin, date, nil, full_day: true).call
    assert account.bookings.full_day_blocked_for(date).exists?

    Bookings::BlockSchedule.new(admin, date, schedule_category.id).call
    refute account.bookings.full_day_blocked_for(date).exists?
  end

  test "creates blocked booking with blocked_name" do
    date = Date.current + 20.days
    booking = Bookings::BlockSchedule.new(admin, date, schedule_category.id, blocked_name: "Mantenimiento").call

    assert booking.persisted?
    assert_equal "Mantenimiento", booking.blocked_name
  end

  private

    def account
      @account ||= accounts(:account)
    end

    def admin
      @admin ||= users(:admin)
    end

    def regular
      @regular ||= users(:regular)
    end

    def schedule_category
      @schedule_category ||= schedule_categories(:schedule_category)
    end
end
