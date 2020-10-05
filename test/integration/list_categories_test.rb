require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @cat1 = Category.create(name: 'Sports')
    @cat2 = Category.create(name: 'Travel')
  end
  
  test "should show categories listing" do
    get '/categories'

    assert_select 'a[href=?]', category_path(@cat1), @cat1.name
    assert_select 'a[href=?]', category_path(@cat2), @cat2.name
  end
end
