class SupplierTypesController < ApplicationController
  before_action :set_supplier_type, only: %i[ show update destroy ]

  # GET /supplier_types
  def index
    @supplier_types = SupplierType.all

    render json: @supplier_types
  end

  # GET /supplier_types/1
  def show
    render json: @supplier_type
  end

  # POST /supplier_types
  def create
    @supplier_type = SupplierType.new(supplier_type_params)

    if @supplier_type.save
      render json: @supplier_type, status: :created, location: @supplier_type
    else
      render json: @supplier_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /supplier_types/1
  def update
    if @supplier_type.update(supplier_type_params)
      render json: @supplier_type
    else
      render json: @supplier_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /supplier_types/1
  def destroy
    @supplier_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier_type
      @supplier_type = SupplierType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supplier_type_params
      params.require(:supplier_type).permit(:name)
    end
end
