class Order < ApplicationRecord
  belongs_to :user
  belongs_to :first_course, class_name: 'Price'
  belongs_to :main_course, class_name: 'Price'
  belongs_to :drink, class_name: 'Price'

  def add_course(price)
    case price.item.course
    when 'first_course'
      self.first_course = price
    when 'main_course'
      self.main_course = price
    when 'drink'
      self.drink = price
    end
  end

  def created_date
    created_at.to_datetime.to_date
  end
end
