class SupplierCategoriesController < ApplicationController
  before_action :set_supplier_category, only: %i[ show update destroy ]

  # GET /supplier_categories
  def index
    @supplier_categories = SupplierCategory.all

    render json: @supplier_categories
  end

  # GET /supplier_categories/1
  def show
    render json: @supplier_category
  end

  # POST /supplier_categories
  def create
    @supplier_category = SupplierCategory.new(supplier_category_params)

    if @supplier_category.save
      render json: @supplier_category, status: :created, location: @supplier_category
    else
      render json: @supplier_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /supplier_categories/1
  def update
    if @supplier_category.update(supplier_category_params)
      render json: @supplier_category
    else
      render json: @supplier_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /supplier_categories/1
  def destroy
    @supplier_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier_category
      @supplier_category = SupplierCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supplier_category_params
      params.require(:supplier_category).permit(:name)
    end
end
