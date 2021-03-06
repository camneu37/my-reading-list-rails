class User < ApplicationRecord
  has_and_belongs_to_many :books
  has_many :comments, dependent: :destroy
  has_many :books_commented, through: :comments, source: "book_commented"

  validates :name, :username, :password, presence: true
  validates :username, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_secure_password

  def add_book_to_reading_list(book)
    books << book
  end

  def remove_book_from_reading_list(book)
    books.delete(book)
  end

  def reading_list_alphabetized
    books.order(:title)
  end

  def self.find_or_create_from_auth(auth)
    find_or_create_by(uid: auth[:uid]) do |u|
      u.name = auth[:info][:name].split(" ")[0]
      u.username = auth[:info][:name].downcase.split(" ").join("_")
      u.password = SecureRandom.hex
      u.password_confirmation = u.password
    end
  end

end
