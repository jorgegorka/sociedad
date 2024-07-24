require 'test_helper'

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Current.user = users(:mario)
  end

  test 'should not get index when regular user' do
    Current.user = users(:regular)

    get admin_accounts_path

    assert_not @valid
  end

  test 'index' do
    get admin_accounts_path

    assert_response :success
  end

  test 'should get new' do
    get new_admin_account_url

    assert_response :success
  end

  test 'should create an account' do
    post admin_accounts_url, params: { account: { name: 'New account', email: 'newaccount@test.com' } }

    assert_response :redirect

    account1 = Account.last

    assert_equal 'New account', account1.name
    assert_equal 'newaccount@test.com', account1.email
  end

  test 'should get edit' do
    get new_admin_account_url

    assert_response :success
  end

  test 'should update an account' do
    put admin_account_url(account), params: { account: { name: 'Updated account' } }

    assert_response :redirect

    assert_equal 'Updated account', account.reload.name
  end

  test 'should destroy an account' do
    assert_difference 'Account.count', -1 do
      delete admin_account_path(account)
    end
  end

  private

  def account
    @account ||= accounts(:account)
  end
end
