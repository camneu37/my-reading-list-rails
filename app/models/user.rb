class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, format: /@/
  has_and_belongs_to_many :books
  has_many :comments
  has_many :books_commented, through: :comments, source: 'book_commented'

  def add_book_to_reading_list(book)
    books << book
  end
end
