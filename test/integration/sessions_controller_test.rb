require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mario)
  end

  test 'should get new' do
    get new_session_url

    assert_response :success
  end

  test 'should login an user by email' do
    post sessions_url, params: { login: @user.email, password: 'testme' }

    assert_response :redirect
  end

  test 'should login an user by username' do
    post sessions_url, params: { login: @user.username, password: 'testme' }

    assert_response :redirect
  end

  test 'should not login an user by invalid username' do
    post sessions_url, params: { login: 'invalid name', password: 'testme' }

    assert_response :unprocessable_entity
  end
end
