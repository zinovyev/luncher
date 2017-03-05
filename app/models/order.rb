class Order < ApplicationRecord
  belongs_to :user
  belongs_to :first_course, class_name: 'Price', optional: true
  belongs_to :main_course, class_name: 'Price', optional: true
  belongs_to :drink, class_name: 'Price', optional: true

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

  def contains_course(price)
    self.class.where(
      "
      (
        first_course_id = :price_id \
          OR main_course_id = :price_id \
          OR drink_id = :price_id \
      ) AND id = :order_id",
      price_id: price.id,
      order_id: self.id
    ).count.positive?
  end

  def created_date
    created_at.to_datetime.to_date
  end
end
