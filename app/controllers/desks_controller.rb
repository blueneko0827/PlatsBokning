class DesksController < ApplicationController
  before_action :set_desk, only: %i[ show update destroy ]

  # GET /desks
  def index
    @desks = Desk.all

    render json: @desks
  end

  # GET /desks/1
  def show
    render json: @desk
  end

  # POST /desks
  def create
    @desk = Desk.new(desk_params)

    if @desk.save
      render json: @desk, status: :created, location: @desk
    else
      render json: @desk.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /desks/1
  def update
    if @desk.update(desk_params)
      render json: @desk
    else
      render json: @desk.errors, status: :unprocessable_entity
    end
  end

  # DELETE /desks/1
  def destroy
    @desk.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_desk
      @desk = Desk.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def desk_params
      params.require(:desk).permit(:floor_number, :desk_number, :status_id, :fixed_employee_id)
    end
end
