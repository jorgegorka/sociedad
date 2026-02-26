require "test_helper"

class BookingTest < ActiveSupport::TestCase
  test "blocked defaults to false" do
    booking = Booking.new
    assert_equal false, booking.blocked
  end

  test "full_day defaults to false" do
    booking = Booking.new
    assert_equal false, booking.full_day
  end

  test "blocked_for scope returns blocked bookings" do
    blocked = bookings(:blocked_booking)
    results = Booking.blocked_for(blocked.start_on, blocked.schedule_category_id)

    assert_includes results, blocked
  end

  test "blocked_for scope does not return regular bookings" do
    regular = bookings(:booking1_sc1)
    results = Booking.blocked_for(regular.start_on, regular.schedule_category_id)

    assert_not_includes results, regular
  end

  test "full_day_blocked_for scope returns full day blocked bookings" do
    blocked = bookings(:blocked_full_day)
    results = Booking.full_day_blocked_for(blocked.start_on)

    assert_includes results, blocked
  end

  test "full_day_blocked_for scope does not return regular blocked bookings" do
    blocked = bookings(:blocked_booking)
    results = Booking.full_day_blocked_for(blocked.start_on)

    assert_not_includes results, blocked
  end

  test "full_day blocked booking does not require schedule_category" do
    booking = Booking.new(
      user: users(:admin),
      start_on: Date.current + 25.days,
      participants: 0,
      blocked: true,
      full_day: true,
      blocked_name: "Test"
    )

    assert booking.valid?
  end

  test "regular booking requires schedule_category" do
    booking = Booking.new(
      user: users(:admin),
      start_on: Date.current + 25.days,
      participants: 0
    )

    assert_not booking.valid?
    assert booking.errors[:schedule_category_id].any?
  end

  test "schedule_not_blocked prevents booking on full_day blocked date" do
    blocked = bookings(:blocked_full_day)
    Current.account = accounts(:account)

    booking = Booking.new(
      user: users(:regular),
      schedule_category: schedule_categories(:schedule_category),
      start_on: blocked.start_on,
      participants: 5
    )

    assert_not booking.valid?(:create)
    assert booking.errors[:base].any?
  end
end
