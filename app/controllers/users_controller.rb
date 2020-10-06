class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You've signed up to Alpha Blog #{@user.username}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit   
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if @user == current_user
      session[:user_id] = nil
      @current_user = nil
    end
    
    @user.destroy    

    flash[:notice] = "Account and all associated articles were deleted!"
    redirect_to users_path
  end

  private 
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit/delete your own profile"
      redirect_to @user
    end
  end
end