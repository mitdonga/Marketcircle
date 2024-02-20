class InfosController < ApplicationController
  before_action :set_info, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ create ]
  before_action :set_pagination, only: %i[ index ]

  # GET /infos or /infos.json
  def index
    @infos = Info.includes(:user)
              .limit(@per_page).offset((@page - 1) * @per_page)
  end

  # GET /infos/1 or /infos/1.json
  def show
  end

  # GET /infos/new
  def new
    @info = Info.new
  end

  # GET /infos/1/edit
  def edit
  end

  # POST /infos or /infos.json
  def create
    @info = Info.new(info_create_params)
    @info.user = @user
    respond_to do |format|
      if @info.save
        format.html { redirect_to info_url(@info), notice: "Info was successfully created" }
        format.json { render :show, status: :created, location: @info }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @info.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infos/1 or /infos/1.json
  def update
    respond_to do |format|
      if @info.update(info_params)
        format.html { redirect_to info_url(@info), notice: "Info was successfully updated" }
        format.json { render :show, status: :ok, location: @info }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @info.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infos/1 or /infos/1.json
  def destroy
    @info.destroy

    respond_to do |format|
      format.html { redirect_to infos_url, notice: "Info was successfully destroyed" }
      format.json { render json: { message: "Info was successfully deleted" }, status: :ok }
    end
  end

  private

  def set_info
    @info = Info.find_by(id: params[:id])
    render json: { message: "Info not found" }, status: :not_found unless @info.present?
  end

  def set_user
    @user = User.find_by(id: params[:info][:user_id]) rescue nil
    render json: { message: "User not found" }, status: :not_found unless @user.present?
    render json: { error: "Info already present for #{@user.name}" }, status: :unprocessable_entity if @user.info.present?
  end

  # Only allow a list of trusted parameters through.
  def info_params
    params.require(:info).permit(:title, :age, :phone, :email)
  end

  def info_create_params
    params.require(:info).permit(:title, :age, :phone, :email, :user_id)
  end

  def set_pagination
    @page = params[:page].present? ? params[:page].to_i : 1
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    @total_infos = Info.count
  end
end
