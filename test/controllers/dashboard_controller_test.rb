require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    log_in_user

    get dashboard_index_path
    assert_response :success
  end
end
