class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :users
  has_many :comments, dependent: :destroy
  has_many :comment_writers, through: :comments, source: "comment_writer"
  has_many :ratings, as: :rateable


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
      where("created_at >= ?", Date.today.days_ago(1)).order(:title)
    when "Week"
      where("created_at >= ?", Date.today.weeks_ago(1)).order(:title)
    when "Month"
      where("created_at >= ?", Date.today.months_ago(1)).order(:title)
    when "Year"
      where("created_at >= ?", Date.today.years_ago(1)).order(:title)
    end
  end

  def self.all_alphabetized
    order(:title)
  end

  def self.new_from_params(params, params_author_name)
    book = self.new(params)
    book.add_author(params, params_author_name)
    book
  end

  def update_from_params(params, params_author_name)
    update(params)
    add_author(params, params_author_name)
    self
  end

  def add_author(params, params_author_name)
    if !params_author_name.blank? && params[:author_id].empty?
      author = Author.create(name: params_author_name)
      if author.errors[:name].any?
        errors.add(:author, "already exists, please select their name from the dropdown")
      else
        update(author: author)
      end
    elsif !params_author_name.blank? && !params[:author_id].empty?
      errors.add(:author, "must be either selected from existing list or a new name entered")
    elsif params_author_name.blank? && params[:author_id].empty?
      errors.add(:author, "must be entered")
    end
  end

end
