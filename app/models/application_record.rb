class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def avg_rating(class_type)
    Rating.avg_rating(class_type, self)
  end

  def already_rated_by_user?(user)
    ratings.any?{|r| r.user_id == user.id}
  end

end
