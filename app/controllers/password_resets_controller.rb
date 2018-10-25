class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "확인 메일이 전송되었습니다"
      redirect_to root_url
    else
      flash.now[:danger] = "이메일 주소를 찾을 수 없습니다"
      render 'new'
    end
  end

  def edit
  end
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, " 칸을 입력해 주세요.")
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "비밀번호가 재설정되었습니다"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "시간이 만료된 링크입니다"
      redirect_to new_password_reset_url
    end
  end

end
