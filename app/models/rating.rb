class Rating < ApplicationRecord
  belongs_to :rateable, polymorphic: true

  validates :rating, numericality: {greater_than: 0, less_than_or_equal_to: 5}

  def self.avg_rating(type, object)
    where(rateable_type: type, rateable_id: object.id).average(:rating)
  end


end
