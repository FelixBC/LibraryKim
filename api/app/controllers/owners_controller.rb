class OwnersController < ApplicationController
  before_action :set_owner, only: %i[ show update destroy ]

  # GET /owners
  def index
    @owners = Owners.all

    render json: @owners
  end

  # GET /owners/1
  def show
    render json: @owner
  end

  # POST /owners
  def create
    @owner = Owners.new(owner_params)

    if @owner.save
      render json: @owner, status: :created, location: owners_url
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/1
  def update
    if @owner.update(owner_params)
      render json: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /owners/1
  def destroy
    @owner.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owners.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
      def owner_params
        params.require(:owner).permit(:id, :name, :age, :phone, :city, :identificationNumber, :wins, :loses, :lastName)
      end

end