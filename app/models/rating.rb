class Rating < ApplicationRecord
  belongs_to :rateable, polymorphic: true

  validates :rating, numericality: {greater_than: 0, less_than_or_equal_to: 5}
end
