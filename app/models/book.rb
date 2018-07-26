class Book < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :genre, inclusion: { in: %w(Fiction Non-fiction)}
  has_and_belongs_to_many :users
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :comment_writers, through: :comments, source: 'comment_writer'
  before_validation :make_title_case

  def make_title_case
    self.title = self.title.titlecase if self.title
  end

  def author_name
    self.author.name
  end

  def self.added_in_past(timeframe)
    case timeframe
      when "Day"
        find_by_date_added(Date.today.days_ago(1))
      when "Week"
        find_by_date_added(Date.today.weeks_ago(1))
      when "Month"
        find_by_date_added(Date.today.months_ago(1))
      when "Year"
        find_by_date_added(Date.today.years_ago(1))
    end
  end

  def self.all_alphabetized
    order(:title)
  end

  private

    def self.find_by_date_added(date)
      where("created_at >= ?", date)
    end
end
