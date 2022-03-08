require "test_helper"

class Guest::BooksControllerTest < ActionController::TestCase
  def test_index
    article_1 = FactoryBot.create(:book, created_at: "2020-04-25")
    article_2 = FactoryBot.create(:book, created_at: "2020-04-26")

    get :index

    assert_template "guest/books/index"
    assert_primary_keys([article_2, article_1], assigns(:articles))
  end

  def test_show
    book = FactoryBot.create(:book)

    get :show, params: { id: book }

    assert_template "guest/books/show"
    assert_equal(book, assigns(:book))
  end
end
