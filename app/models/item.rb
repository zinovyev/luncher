class Item < ApplicationRecord
  COURSE_FIRST = 1
  COURSE_MAIN = 2
  COURSE_DRINK = 3

  has_many :prices
  enum course: [:first_course, :main_course, :drink]
  validates :title, presence: true
  validates :course, presence: true
end
