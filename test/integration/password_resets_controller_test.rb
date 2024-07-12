require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test 'should update the password' do
    old_password = user.password_digest
    user.enable_reset_password

    params = { user: { password: 'new_password', password_confirmation: 'new_password' } }

    put(password_reset_url(user.reset_token), params:)

    assert_response :redirect

    assert_not_equal old_password, user.reload.password_digest
    assert_nil user.reload.reset_token
    assert_nil user.reload.reset_expires_at
  end

  test 'should not get edit page' do
    user.enable_reset_password

    user.update(reset_expires_at: 20.hours.ago)

    get edit_password_reset_path(user.reset_token)

    assert_response :redirect
  end

  test 'should get edit page' do
    user.enable_reset_password

    get edit_password_reset_path(user.reset_token)

    assert_response :success
  end

  def user
    @user ||= users(:regular)
  end
end
