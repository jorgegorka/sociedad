require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    Current.user = users(:mario)
  end

  test 'should not get index when regular user' do
    Current.user = users(:regular)

    get admin_account_users_path(account)

    assert_not @valid
  end

  test 'index' do
    get admin_account_users_path(account)

    assert_response :success
  end

  test 'should get new' do
    get new_admin_account_user_path(account)

    assert_response :success
  end

  test 'should create a user' do
    post admin_account_users_path(account),
         params: { user: { name: 'New user', username: 'username', email: 'user@test.com', password: 'test' } }

    assert_response :redirect

    user1 = account.users.last

    assert_equal 'New user', user1.name
    assert_equal 'user@test.com', user1.email
    assert_equal 'username', user1.username
  end

  test 'should get edit' do
    get edit_admin_account_user_path(account, user)

    assert_response :success
  end

  test 'should update a user' do
    put admin_account_user_path(account, user), params: { user: { name: 'Updated user' } }

    assert_response :redirect

    assert_equal 'Updated user', user.reload.name
  end

  test 'should destroy an account' do
    assert_difference 'account.users.count', -1 do
      delete admin_account_user_path(account, user)
    end
  end

  private

  def account
    @account ||= accounts(:account)
  end

  def user
    @user ||= users(:mario)
  end
end
