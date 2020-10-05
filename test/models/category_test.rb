require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name shoud be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name shoud be unique" do
    @category.save
    @invalid_category = Category.new(name: "Sports")
    assert_not @invalid_category.valid?
  end

  test "name shoud not be too long" do
    @category.name = "x" * 26
    assert_not @category.valid?
  end

  test "name shoud not be too short" do
    @category.name = "ab"
    assert_not @category.valid?
  end

end
