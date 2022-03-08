class Book < ApplicationRecord
  self.primary_key = :slug
  log_book
  strip_attributes

  belongs_to :author

  before_validation :initialize_slug

  validates :title, presence: true, uniqueness: {scope: :author}
  validates :slug, presence: true, uniqueness: true
  validates :author, presence: true

  scope :order_by_recent, -> { order("created_at desc") }

  private

  def initialize_slug
    self.slug ||= title.parameterize
  end
end
