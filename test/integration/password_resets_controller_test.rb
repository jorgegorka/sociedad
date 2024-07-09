require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test 'should update the password' do
    old_password = user.password
    user.assign_forget_attributes
    debugger
    params = { user: { password: 'new_password', password_confirmation: 'new_password' } }

    put(password_reset_url(user.forget_token), params:)

    assert_response :success

    assert_not_equal old_password, user.reload.password
  end

  def user
    @user ||= users(:regular)
  end
end
