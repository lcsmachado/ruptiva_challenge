class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: %i[update destroy]

  def index
    @users = User.all
    authorize @users
  end
  
  def create
    @user = User.new
    @user.attributes = user_params
    save_user!
  end

  def update
    @user.attributes = user_params
    authorize @user
    save_user!
  end

  def destroy
    authorize @user
    @user.destroy!
  rescue StandardError
    render_error(fields: @user.errors.messages)
  end

  private

  def user_params
    return {} unless params.has_key?(:user)

    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end

  def load_user
    @user = User.find(params[:id])
  end

  def save_user!
    @user.save!
    render :show
  rescue StandardError
    render_error(fields: @user.errors.messages)
  end

end
