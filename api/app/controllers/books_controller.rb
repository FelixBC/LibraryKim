class BooksController < ApplicationController
  def index
    books = Book.all
    render json: books
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end

  def create
    book = Book.create(book_params)
    render json: book
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    render json: book
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    render json: book
  end

  def general_params
    @genres = Book.genres.map { |k, v| { id: v, name: k } }
    render json: @genres
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :genre_id, :quantity, :price, :rating, :image_url)
  end
end
