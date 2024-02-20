class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_pagination, only: %i[ index ]

  # GET /users
  def index
    @users = User.includes(:info)
              .limit(@per_page).offset((@page - 1) * @per_page)
  end

  # GET /users/:id
  def show
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    render json: { notice: "User was successfully deleted" }
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, info_attributes: [:title, :age, :phone, :email])
  end

  def set_pagination
    @page = params[:page].present? ? params[:page].to_i : 1
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    @total_users = User.count
  end
end
