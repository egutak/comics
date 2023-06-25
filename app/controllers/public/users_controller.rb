class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @favorites = current_user.favorites
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to public_users_my_page_path
    else
      redirect_to request.referer
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to public_users_path(current_user)
    end
  end
end
