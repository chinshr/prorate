require "test_helper"

class InvestmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get investments_index_url
    assert_response :success
  end
end
