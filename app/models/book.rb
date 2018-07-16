class Book < ApplicationRecord
  validates :title, presence: true
  validates :genre, inclusion: { in: %w(Fiction Non-fiction)}
  has_and_belongs_to_many :users
  belongs_to :author
  has_many :comments
  has_many :comment_writers, through: :comments, source: 'comment_writer'
  before_save :make_title_case

  def make_title_case
    self.title = self.title.titlecase
  end

  def author_name
    self.author.name
  end
end
