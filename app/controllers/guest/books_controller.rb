class Guest::BooksController < Guest::BaseController
  before_action :load_book, only: [:show]

  def index
    @articles = Book.order_by_recent.page(params[:page]).per(10)
  end

  def show; end

  private

  def load_book
    @book = Book.find(params[:id])
  end
end
