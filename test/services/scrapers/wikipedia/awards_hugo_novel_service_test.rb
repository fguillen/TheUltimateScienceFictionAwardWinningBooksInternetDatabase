require "test_helper"

class Scrapers::Wikipedia::AwardsHugoNovelServiceTest < ActiveSupport::TestCase
  def test_perform
    Scrapers::Wikipedia::ExtractBookInformationService.expects(:perform).at_least_once

    VCR.use_cassette("ScrapersWikipediaAwardsHugoNovelService") do
      Scrapers::Wikipedia::AwardsHugoNovelService.perform
    end
  end

  # def test_perform_simple
  #   table = JSON.parse(read_fixture("table_hugo_awards_novella_1968.json"))
  #   Scrapers::Wikipedia::AwardsHugoNovelService.any_instance.expects(:table_rows).returns(table)

  #   Scrapers::Wikipedia::AwardsHugoNovelService.perform

  #   puts "books: #{Book.count}"
  #   puts "book: #{Book.first.title}"
  # end
end
