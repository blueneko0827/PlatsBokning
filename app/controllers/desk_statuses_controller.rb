class DeskStatusesController < ApplicationController
  before_action :set_desk_status, only: %i[ show update destroy ]

  # GET /desk_statuses
  def index
    @desk_statuses = DeskStatus.all

    render json: @desk_statuses
  end

  # GET /desk_statuses/1
  def show
    render json: @desk_status
  end

  # POST /desk_statuses
  def create
    @desk_status = DeskStatus.new(desk_status_params)

    if @desk_status.save
      render json: @desk_status, status: :created, location: @desk_status
    else
      render json: @desk_status.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /desk_statuses/1
  def update
    if @desk_status.update(desk_status_params)
      render json: @desk_status
    else
      render json: @desk_status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /desk_statuses/1
  def destroy
    @desk_status.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_desk_status
      @desk_status = DeskStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def desk_status_params
      params.require(:desk_status).permit(:status_name)
    end
end
