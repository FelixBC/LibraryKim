class RoostersController < ApplicationController
  before_action :set_rooster, only: %i[ show update destroy ]

  # GET /roosters
  def index
    @roosters = Rooster.all

    render json: @roosters
  end

  # GET /roosters/1
  def show
    render json: @rooster
  end

  # POST /roosters
  def create
    @rooster = Rooster.new(rooster_params)

    if @rooster.save
      render json: @rooster, status: :created, location: rooster_url
    else
      render json: @rooster.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roosters/1
  def update
    if @rooster.update(rooster_params)
      render json: @rooster
    else
      render json: @rooster.errors, status: :unprocessable_entity
    end
  end

  # DELETE /roosters/1
  def destroy
    @rooster.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rooster
      @rooster = Rooster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rooster_params
      params.require(:rooster).permit(:name, :breed_id, :color_id, :wins, :loses, :strength, :resistance, :agility, :defence, :owners_id)
    end
end
