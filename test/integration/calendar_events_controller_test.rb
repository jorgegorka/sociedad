require "test_helper"

class CalendarEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_manager
  end

  test "index" do
    get calendar_events_path

    assert_response :success
  end
end
