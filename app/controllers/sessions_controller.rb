class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: session_params[:email].downcase).try(:authenticate, session_params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.username}"
      redirect_to user
    else
      # When you render a partial there's no HTTP request made so
      # the flash[:notice] could not happen.
      # When you trigger a flash.now the message is immediatelly presented
      # flash[:notice] = "Incorrect email and/or password"
      flash.now[:alert] = "Incorrect email and/or password"
      render 'new'
    end
  end
  
  def destroy
    if session[:user_id]
      session[:user_id] = nil
      flash[:notice] = "Logged out! See you later!"
      redirect_to root_path
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end