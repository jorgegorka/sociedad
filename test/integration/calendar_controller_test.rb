require "test_helper"

class CalendarControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_manager
  end

  test "index" do
    get calendar_index_path

    assert_response :success
  end
end
