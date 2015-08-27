require 'test_helper'

class Admin::HousesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get editt" do
    get :editt
    assert_response :success
  end

end
