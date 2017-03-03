class Order < ApplicationRecord
  belongs_to :user
  # has_one :price
  belongs_to :first_course, class_name: 'Price'
  belongs_to :main_course, class_name: 'Price'
  belongs_to :drink, class_name: 'Price'
end
