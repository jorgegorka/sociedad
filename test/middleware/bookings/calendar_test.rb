require "test_helper"

class Bookings::CalendarTest < ActiveSupport::TestCase
  test "call" do
    result = Bookings::Calendar.call account, Date.current.strftime("%Y-%m")

    assert_equal 1, result.first[:bookings].size
    assert_equal 1, result[14][:bookings].size
    assert_equal 2, result[4][:bookings].size
  end

  private

    def account
      @account ||= accounts(:account)
    end
end
