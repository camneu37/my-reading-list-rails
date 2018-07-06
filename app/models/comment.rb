class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :book_commented, class_name: "Book", foreign_key: 'book_id'
  belongs_to :comment_writer, class_name: "User", foreign_key: 'user_id'
end
