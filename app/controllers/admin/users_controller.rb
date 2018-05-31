class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.order :email
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

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
