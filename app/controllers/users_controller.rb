class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: %i[show update destroy]
  rescue_from Pundit::NotAuthorizedError, with: :forbidden_access

  def index
    @users = User.all
    authorize @users
  end
  
  def show
    authorize @user
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
    soft_delete
  end

  private

  def forbidden_access
    render_error(message: 'Forbidden access', status: :forbidden)
  end

  def user_params
    return {} unless params.has_key?(:user)
    byebug
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
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

  def soft_delete
    @user.deleted = true
    @user.save!
  end
end
