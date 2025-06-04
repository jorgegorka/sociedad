require "test_helper"

class Admin::CustomAttributesControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_admin
  end

  test "should not get index when regular user" do
    log_in_user

    get admin_custom_attributes_path

    assert_response :redirect
    assert_not @valid
  end

  test "index" do
    get admin_custom_attributes_path

    assert_response :success
  end

  test "should get new" do
    get new_admin_custom_attribute_path

    assert_response :success
  end

  test "should create a resource" do
    post admin_custom_attributes_path,
         params: { custom_attribute: { name: "New attribute", block_on_schedule: true } }

    assert_response :redirect

    custom_attribute1 = CustomAttribute.last

    assert_equal "New attribute", custom_attribute1.name
    assert custom_attribute1.block_on_schedule
  end

  test "should get edit" do
    get edit_admin_custom_attribute_path(custom_attribute)

    assert_response :success
  end

  test "should update a custom attribute" do
    put admin_custom_attribute_path(custom_attribute), params: { custom_attribute: { name: "Updated custom attribute",
       block_on_schedule: false } }

    assert_response :redirect

    assert_equal "Updated custom attribute", custom_attribute.reload.name
    assert_not custom_attribute.reload.block_on_schedule
  end

  test "should destroy a custom attribute" do
    assert_difference "CustomAttribute.count", -1 do
      delete admin_custom_attribute_path(custom_attribute)
    end
  end

  private

    def custom_attribute
      @custom_attribute ||= custom_attributes(:custom_attribute)
    end
end
