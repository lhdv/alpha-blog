require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @adm_usr = User.create(username: 'jon', email: 'jon@example.com', password: 'password', admin: true)  
    sign_in_as(@adm_usr)
  end

  test "create a new article without categories" do
    get '/articles/new'
    assert_response :success

    assert_difference 'Article.count', 1 do
      post articles_url, params: { article: { title: "Integration Test Article", description: "This article shows how to create an integration test" }, category_ids: [] }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_select 'h2', "Integration Test Article"
  end
end
