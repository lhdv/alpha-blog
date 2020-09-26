class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    # Debug method
    # render plain: params[:article]

    # Can't perform the following assigment due strong parameters validation
    # @article = Article.new(params[:article])

    @article = Article.new(params.require(:article).permit(:title, :description))
    # render plain: @article
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
    @article = Article.find(params[:id])
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
    
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))    
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      # Will render the 'edit' method from controller  
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
end
