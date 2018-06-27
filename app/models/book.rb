class Book < ApplicationRecord
  validates :title, presence: true
  validates :genre, inclusion: { in: %w(Fiction Non-fiction)}
  has_and_belongs_to_many :users
  belongs_to :author
end
