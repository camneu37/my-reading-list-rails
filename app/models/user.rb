class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, presence: true {message: "All fields must be completed."}
  validates :email, uniqueness: true
end
