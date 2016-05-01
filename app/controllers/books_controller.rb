class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    @books = Book.paginate(page: params[:page])
  end

  def show
    @book = Books.find(params[:id])
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to books_url
  end

  private

    def params_book
      params.require(:book).permit(:title, :description, :category, :author)
    end
end
