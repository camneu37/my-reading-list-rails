class Author < ApplicationRecord
  validates :name, presence: true
  has_many :books
  before_save :make_name_upcase

  def make_name_upcase
    self.name = self.name.split(" ").collect{|w| w.capitalize}.join(" ")
  end

end
