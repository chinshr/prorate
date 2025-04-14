require "test_helper"

class ProrateControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get prorate_create_url
    assert_response :success
  end
end
