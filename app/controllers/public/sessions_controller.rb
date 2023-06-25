# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_user, only: [:create]

  def after_sign_in_path_for(resource)
    public_books_path
  end

  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def check_user
    # ユーザーの情報をメールアドレスから取得
    user = User.find_by(email: params[:user][:email])
    if user.nil? # ユーザーが存在しなければチェック
      # ユーザーが存在していないので、新規登録をリダイレクト
      redirect_to new_user_registration_path
    else
      # ユーザーが退会済みなら、新規登録へリダイレクト
      if user.is_deleted
        redirect_to new_user_registration_path
      end
    end
  end
end
