class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :ratings, as: :rateable

  validates :name, presence: true, uniqueness: true

  before_validation :make_name_upcase

  def make_name_upcase
    self.name = self.name.split(" ").collect{|w| w.capitalize}.join(" ") if self.name
  end

  def self.all_alphabetized
    order(:name)
  end

end
