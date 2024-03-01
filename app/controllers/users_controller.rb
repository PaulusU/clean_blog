class UsersController < ApplicationController  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @blog_posts = @user.blog_post.order(created_at: :desc)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "User not found"
    redirect_to root_path
  end

  def users
    if current_user.admin?
      @user = User.all
      @user = User.paginate(page: params[:page])
    else
      redirect_to root_path, status: :see_other
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Registration Success !"
      redirect_to login_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user == @user || current_user.admin?
      return false
    else 
      flash[:danger] = "You don't have a access !"
      redirect_to root_path
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    if current_user.admin?
      redirect_to users_path
    else
      redirect_to login_path, status: :see_other
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

end
