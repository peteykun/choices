class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :check_if_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:id).paginate(page: params[:page], per_page: 10)
    @sort_by = 'id'
  end

  def leaderboard
    @users = User.all.sort_by(&:score).reverse.paginate(page: params[:page], per_page: 10)
    @sort_by = 'score'

    render 'index'
  end

  def show
    @answers = @user.answers.order(:question_id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_user
      @user = ::User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :college, :email, :phone, :username, :password, :password_confirmation, :is_admin)
    end
end
