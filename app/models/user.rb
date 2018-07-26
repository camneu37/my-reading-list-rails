class User < ApplicationRecord
  has_secure_password
  validates :name, :username, :password, presence: true
  validates :username, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  has_and_belongs_to_many :books
  has_many :comments
  has_many :books_commented, through: :comments, source: 'book_commented'

  def add_book_to_reading_list(book)
    books << book
  end

  def remove_book_from_reading_list(book)
    books.delete(book)
  end

  def reading_list_alphabetized
    books.order(:title)
  end
end
