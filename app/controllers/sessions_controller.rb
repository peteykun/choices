class SessionsController < ApplicationController
  layout 'user_area'
  before_action :check_if_logged_out, only: [:new, :create]
  before_action :check_if_logged_in,  only: [:destroy]

  def new
  end

  def create
    user = User.find_by_username(params[:username].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      @error = "Looks like you've entered an invalid username or password."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
