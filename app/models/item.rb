class Item < ApplicationRecord
  has_many :prices
  enum course: [:first_course, :main_course, :drink]
  validates :title, presence: true
  validates :course, presence: true
end
