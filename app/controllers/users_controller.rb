class UsersController < ApplicationController
  layout 'user_area'
  before_action :check_if_logged_out

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_admin = false
    @user.username.downcase!
    @user.email.downcase!

    if @user.save
      redirect_to login_path, notice: 'Successfully registered. You can log in now.'
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :college, :email, :phone, :username, :password, :password_confirmation)
    end
end
