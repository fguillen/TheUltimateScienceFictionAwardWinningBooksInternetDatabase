FactoryBot.define do
  factory :admin_user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { "Pass$$$!" }
  end

  factory :admin_authorization do
    provider { "google_oauth2" }
    sequence(:uid)
    admin_user
  end

  factory :front_authorization do
    provider { "google_oauth2" }
    sequence(:uid)
    front_user
  end

  factory :front_user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { "Pass$$$!" }
  end

  factory :article do
    title { Faker::Lorem.sentence(word_count: 20) }
    body { Faker::Lorem.sentence(word_count: 20) }
    front_user
  end

  factory :log_book_event, :class => LogBook::Event  do
    differences { "Wadus Event" }
    association :historizable, factory: :article
  end

  factory :author do
    name { Faker::Name.unique.name }
  end

  factory :book do
    title { Faker::Book.unique.title }
    author
  end

  factory :award do
    name { Faker::TvShows::Simpsons.unique.character }
    category { "Novel" }
  end

  factory :award_winner do
    award
    book
    year { 2020 }
    position { "winner" }
  end
end
