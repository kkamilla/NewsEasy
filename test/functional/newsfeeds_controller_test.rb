require 'test_helper'

class NewsfeedsControllerTest < ActionController::TestCase
  setup do
    @newsfeed = newsfeeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsfeeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsfeed" do
    assert_difference('Newsfeed.count') do
      post :create, newsfeed: { link: @newsfeed.link, user_id: @newsfeed.user_id }
    end

    assert_redirected_to newsfeed_path(assigns(:newsfeed))
  end

  test "should show newsfeed" do
    get :show, id: @newsfeed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newsfeed
    assert_response :success
  end

  test "should update newsfeed" do
    put :update, id: @newsfeed, newsfeed: { link: @newsfeed.link, user_id: @newsfeed.user_id }
    assert_redirected_to newsfeed_path(assigns(:newsfeed))
  end

  test "should destroy newsfeed" do
    assert_difference('Newsfeed.count', -1) do
      delete :destroy, id: @newsfeed
    end

    assert_redirected_to newsfeeds_path
  end
end
