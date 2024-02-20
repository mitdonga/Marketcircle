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

  # GET /users/new
  def new
    @user = User.new
    @user.build_info
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("users_list", partial: "users/user_list", locals: { user: @user }),
            turbo_stream.replace("user-info", template: "users/show", locals: { user: @user })
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:id
  def destroy
    user = @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { render json: { message: "User was successfully deleted" }, status: :ok }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("user-info", ""),
          turbo_stream.remove(user)
        ]
      end
    end
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
