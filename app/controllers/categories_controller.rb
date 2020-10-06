class CategoriesController < ApplicationController
  before_action :require_admin, except: [:show, :index]

  def index
    # To make the test pass a render could solve or just create the html.erb of the action
    # render html: 'index'

    @categories = Category.paginate(page: params[:page], per_page: 5)
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
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = 'Only admins can create/edit/delete categories'
      redirect_to categories_path
    end
  end
end