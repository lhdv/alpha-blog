require 'test_helper'

class SigninUserTest < ActionDispatch::IntegrationTest
  test "sigin up a new user" do
    get '/signup'
    assert_response :success

    assert_difference 'User.count', 1 do
      post users_url, params: { user: {username: 'Test', email: 'test@example.com', password: 'passwd'} }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success

    assert_select 'h1', "Test's profile"
  end
end
