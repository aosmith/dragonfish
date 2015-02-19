require 'test_helper'

class FrontControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get submit_urls" do
    get :submit_urls
    assert_response :success
  end

  test "should get 400 with empty post to add_site" do
    post :add_site
  end

end
