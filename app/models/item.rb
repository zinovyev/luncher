require 'carrierwave/orm/activerecord'

class Item < ApplicationRecord
  FIRST_COURSE = 0
  MAIN_COURSE = 1
  DRINK = 2
  has_one :first_course, class_name: 'Price'
  has_one :main_course, class_name: 'Price'
  has_one :drink, class_name: 'Price'
  has_many :prices, inverse_of: :item
  enum course: [:first_course, :main_course, :drink]
  validates :title, presence: true
  validates :course, presence: true
  mount_uploader :image, ItemImageUploader

  def image_url
    super || '/images/default_item.jpg'
  end

  def self.course_name(name)
    {
      first_course: 'First Course',
      main_course: 'Main Course',
      drink: 'Drink'
    }[name]
  end
end
