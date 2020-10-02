class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
    # This line was moved to a private method to DRY
    # @article = Article.find(params[:id])

  end

  def new
    @article = Article.new
  end

  def create
    # Debug method
    # render plain: params[:article]

    # Can't perform the following assigment due strong parameters validation
    # @article = Article.new(params[:article])

    @article = Article.new(article_params)
    # render plain: @article
    @article.user = User.first
    if @article.save
      
      flash[:notice] = "Article was created successfully"

      # The command below is equal to the above
      # redirect_to article_path(@article)
      redirect_to @article
    else
      # render plain: @article.errors.full_messages
      
      # Will render the 'new' method from controller  
      render 'new'
    end
  end

  def edit
    # This line was moved to a private method to DRY
    # @article = Article.find(params[:id])

  end

  def update
    # Another debug method already built in in Rails
    # It will stop the execution and open a console in server(probably in your terminal)
    # Enter 'continue' to let the execution continue
    #
    # byebug

    # None of those approaches works! It will trigger an UPDATE sql on ALL table rows
    # if Article.update(params.require(:article).permit(:title, :description))
    # if Article.update(params.require(:article).permit(:id, :title, :description))
    
    # This line was moved to a private method to DRY
    # @article = Article.find(params[:id])

    if @article.update(article_params)    
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      # Will render the 'edit' method from controller  
      render 'edit'
    end
  end

  def destroy
    # This line was moved to a private method to DRY
    # @article = Article.find(params[:id])

    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only edit/delete your own articles"
      redirect_to @article
    end
  end
end
