require 'test_helper'
require 'mocha/minitest'

module Api
  class ProrateControllerTest < ActionDispatch::IntegrationTest
    test "should simple 1" do
      input_data = {
        allocation_amount: 100,
        investor_amounts: [
          {
            name: "Investor A",
            requested_amount: 100,
            average_amount: 100
          },
          {
            name: "Investor B",
            requested_amount: 25,
            average_amount: 25
          }
        ]
      }

      expected_output = {
        "Investor A" => 80,
        "Investor B" => 20
      }

      post api_prorate_url, params: input_data, as: :json
      assert_response :success
      assert_equal expected_output, JSON.parse(response.body)
    end

    test "should simple 2" do
      input_data = {
        allocation_amount: 200,
        investor_amounts: [
          {
            name: "Investor A",
            requested_amount: 100,
            average_amount: 100
          },
          {
            name: "Investor B",
            requested_amount: 25,
            average_amount: 25
          }
        ]
      }

      expected_output = {
        "Investor A" => 100,
        "Investor B" => 25
      }

      post api_prorate_url, params: input_data, as: :json
      assert_response :success
      assert_equal expected_output, JSON.parse(response.body)
    end

    test "should complex 1" do
      input_data = {
        allocation_amount: 200,
        investor_amounts: [
          {
            name: "Investor A",
            requested_amount: 100,
            average_amount: 95
          },
          {
            name: "Investor B",
            requested_amount: 2,
            average_amount: 1
          },
          {
            name: "Investor C",
            requested_amount: 1,
            average_amount: 4
          }
        ]
      }

      expected_output = {
        "Investor A" => 97.96875,
        "Investor B" => 1.03125,
        "Investor C" => 1
      }

      post api_prorate_url, params: input_data, as: :json
      assert_response :success
      assert_equal expected_output, JSON.parse(response.body)
    end

  end
end 