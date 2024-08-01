require 'test_helper'

class Bookings::CreatorTest < ActiveSupport::TestCase
  test 'create booking and resource bookings' do
    params = { start_on: Date.today, schedule_category_id: schedule_category.id, resource_ids: }

    assert_difference 'ResourceBooking.count', 2 do
      assert_difference 'user.bookings.count', 1 do
        Bookings::Creator.new(user.id, params).call
      end
    end
  end

  private

    def user
      @user ||= users(:mario)
    end

    def resource_ids
      [ resource.id, resource2.id ]
    end

    def resource
      @resource ||= resources(:resource)
    end

    def resource2
      @resource2 ||= resources(:resource2)
    end

    def schedule_category
      @schedule_category ||= schedule_categories(:schedule_category)
    end
end
