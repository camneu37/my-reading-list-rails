class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :users
  has_many :comments, dependent: :destroy
  has_many :comment_writers, through: :comments, source: 'comment_writer'


  validates :title, presence: true, uniqueness: true
  validates :genre, inclusion: { in: %w(Fiction Non-fiction)}

  before_validation :make_title_case

  def make_title_case
    self.title = self.title.titlecase if self.title
  end

  def author_name
    author.name
  end

  def self.added_in_past(timeframe)
    case timeframe
    when "Day"
      where("created_at >= ?", Date.today.days_ago(1))
    when "Week"
      where("created_at >= ?", Date.today.weeks_ago(1))
    when "Month"
      where("created_at >= ?", Date.today.months_ago(1))
    when "Year"
      where("created_at >= ?", Date.today.years_ago(1))
    end
  end

  def self.all_alphabetized
    order(:title)
  end

  def self.new_from_params(params, author_name)
    book = self.new(params)
    if !author_name.blank? && params[:author_id].empty?
      author = Author.create(name: author_name)
      if author.errors[:name].any?
        book.errors.add(:author, "already exists, please select their name from the dropdown")
      else
        book.author = author
      end
    elsif !author_name.blank? && !params[:author_id].empty?
      book.errors.add(:author, "must be either selected from existing list or a new name entered")
    end
    book
  end

end
