class ReservationSpacesController < ApplicationController
  before_action :set_reservation_space, only: %i[ show update destroy ]

  # GET /reservation_spaces
  def index
    @reservation_spaces = ReservationSpace.all

    render json: @reservation_spaces
  end

  # GET /reservation_spaces/1
  def show
    render json: @reservation_space
  end

  # POST /reservation_spaces
  def create
    @reservation_space = ReservationSpace.new(reservation_space_params)

    if @reservation_space.save
      render json: @reservation_space, status: :created, location: @reservation_space
    else
      render json: @reservation_space.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservation_spaces/1
  def update
    if @reservation_space.update(reservation_space_params)
      render json: @reservation_space
    else
      render json: @reservation_space.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservation_spaces/1
  def destroy
    @reservation_space.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation_space
      @reservation_space = ReservationSpace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_space_params
      params.require(:reservation_space).permit(:name, :capacity, :availability)
    end
end
