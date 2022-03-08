class Scrapers::Wikipedia::ExtractBookInformationService < ApplicationService
  def initialize(url, book)
    @url = url
    @book = book
  end

  def perform
    info = get_info(@url)

    update_book(@book, info) if info

    @success = true
    @result = @book

    self
  end

  def result
    @result
  end

  def success?
    !!@success
  end

  private

  def clean_value(value)
    if value
      [value].flatten.first["text"]
    end
  end

  def get_info(url)
    puts "url: #{url}"
    puts Wac::Page.new(url).extract.to_hash

    card = Wac::Page.new(url).extract.to_hash["cards"].first

    if card

      content = card.to_hash["content"]
      images = card.to_hash["images"]

      cover_url = images.empty? ? nil : "https:#{images.first}"

      {
        country: clean_value(content["Country"]),
        language: clean_value(content["Language"]),
        publication_date: clean_value(content["Publication date"]),
        pages: clean_value(content["Pages"]).to_i,
        isbn: clean_value(content["ISBN"]),
        cover_url: cover_url
      }
    end
  end

  def update_book(book, info)
    book.update!(info)
  end
end
