class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def avg_rating(class_type)
    Rating.avg_rating(class_type, self)
  end
end
