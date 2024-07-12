require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    Current.user = users(:manager)
  end

  test 'should not get index when regular user' do
    Current.user = users(:regular)

    get users_path

    assert_not @valid
  end

  test 'index' do
    get users_path

    assert_response :success
  end

  test 'should get new' do
    get new_user_path

    assert_response :success
  end

  test 'should create a user' do
    post users_path,
         params: { user: { name: 'New user', username: 'username', email: 'user@test.com', password: 'test' } }

    assert_response :redirect

    user1 = User.last

    assert_equal 'New user', user1.name
    assert_equal 'user@test.com', user1.email
    assert_equal 'username', user1.username
    assert user1.active
  end

  test 'should get edit' do
    get edit_user_path(user)

    assert_response :success
  end

  test 'should update a user' do
    put user_path(user), params: { user: { name: 'Updated user', active: false } }

    assert_response :redirect

    assert_equal 'Updated user', user.reload.name
    assert_not user.reload.active
  end

  test 'should destroy a user' do
    assert_difference 'User.count', -1 do
      delete user_path(user)
    end
  end

  private

  def user
    @user ||= users(:mario)
  end
end
