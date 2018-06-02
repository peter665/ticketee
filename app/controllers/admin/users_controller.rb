class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order :email
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to [:admin, :users]
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_user_path @user
    else
      flash[:danger] = "User has not been updated."
      render 'edit'
    end
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
