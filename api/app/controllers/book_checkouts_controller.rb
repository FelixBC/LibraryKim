class BookCheckoutsController < ApplicationController
  before_action :set_book_checkout, only: %i[ show update destroy ]

  # GET /book_checkouts
  def index
    @book_checkouts = BookCheckout.all

    render json: @book_checkouts
  end

  # GET /book_checkouts/1
  def show
    render json: @book_checkout
  end

  # POST /book_checkouts
  def create
    @book_checkout = BookCheckout.new(book_checkout_params.merge(status_id: BookCheckout.statuses[:checked_out]))

    if @book_checkout.save
      render json: @book_checkout, status: :created, location: @book_checkout
    else
      render json: @book_checkout.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /book_checkouts/1
  def update
    if @book_checkout.update(book_checkout_params)
      render json: @book_checkout
    else
      render json: @book_checkout.errors, status: :unprocessable_entity
    end
  end

  # DELETE /book_checkouts/1
  def destroy
    @book_checkout.destroy
  end

  def general_params
    @statuses = BookCheckout.statuses.map { |k, v| { id: v, name: k } }
    render json: @statuses
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_checkout
      @book_checkout = BookCheckout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_checkout_params
      params.require(:book_checkout).permit(:book_id, :client_id, :status_id)
    end
end
