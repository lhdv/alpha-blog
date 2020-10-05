class CategoriesController < ApplicationController
  def index
    # To make the test pass a render could solve or just create the html.erb of the action
    # render html: 'index'
  end

  def new
    # To make the test pass a render could solve or just create the html.erb of the action
    # render html: 'new'

    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created!"
      redirect_to @category
    else
      render 'new'
    end
  end

  def show
    # To make the test pass a render could solve or just create the html.erb of the action
    # render html: 'show'

    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end