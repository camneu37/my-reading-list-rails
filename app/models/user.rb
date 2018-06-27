class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, format: /@/
  has_and_belongs_to_many :books
end
