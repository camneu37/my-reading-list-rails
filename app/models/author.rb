class Author < ApplicationRecord
  validates :name, presence: true
  has_many :books
  before_validation :make_name_upcase

  def make_name_upcase
    self.name = self.name.split(" ").collect{|w| w.capitalize}.join(" ") if self.name
  end

end
