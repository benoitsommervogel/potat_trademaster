require "test_helper"

class RatesControllerTest < ActionDispatch::IntegrationTest

  test "should get nothing with invalid date" do
    get daily_rates_url("2024-11-22"), as: :json
    assert_response :success
    assert_equal @response.parsed_body, []
  end
  
  test "should get 0 euros for maximum benefits with invalid date" do
    get daily_benefits_url("2024-11-22"), as: :json
    assert_response :success
    assert_equal @response.parsed_body, {"value"=>"0€"}
  end

  test "should get daily rates in order with valid date" do
    get daily_rates_url("2024-11-21"), as: :json
    assert_response :success
    assert_equal @response.parsed_body, [{"time"=>"2024-11-21T12:45:31.000Z", "value"=>1.5},
    {"time"=>"2024-11-21T14:35:31.000Z", "value"=>1.5},
    {"time"=>"2024-11-21T14:45:31.000Z", "value"=>2.0},
    {"time"=>"2024-11-21T14:55:31.000Z", "value"=>3.0},
    {"time"=>"2024-11-21T15:25:31.000Z", "value"=>1.0}]
  end

  test "should get the best benefit possible with valid date" do
    get daily_benefits_url("2024-11-21"), as: :json
    assert_response :success
    assert_equal @response.parsed_body, {"value"=>"150.0€"}
  end
end
