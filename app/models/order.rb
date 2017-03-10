class Order < ApplicationRecord
  belongs_to :user
  belongs_to :first_course, class_name: 'Price', optional: true
  belongs_to :main_course, class_name: 'Price', optional: true
  belongs_to :drink, class_name: 'Price', optional: true

  def to_s
    "#{first_course&.title}, #{main_course&.title}, #{drink&.title}"
  end

  def add_course(price)
    case price.item.course
    when 'first_course'
      self.first_course = toggle_course(first_course, price)
    when 'main_course'
      self.main_course = toggle_course(main_course, price)
    when 'drink'
      self.drink = toggle_course(drink, price)
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
      order_id: id
    ).count.positive?
  end

  def created_date
    created_at.to_datetime.to_date
  end

  def empty?
    !(first_course && main_course && drink)
  end

  def sum
    format('%.2f', (
      first_course&.value.to_f +
      main_course&.value.to_f +
      drink&.value.to_f
    ).to_s)
  end

  def summary
    sum
  end

  private

  def toggle_course(course, price)
    price unless course == price
  end

  class << self
    def list(page = 0)
      page = page.to_i
      page = page > 1 ? page : 1
      limit = 10
      offset = limit * (page.to_i - 1)
      Order.eager_load(
        first_course: [{ item: :first_course }],
        main_course: [{ item: :first_course }],
        drink: [{ item: :first_course }]
      )
           .order(:created_at)
           .offset(offset)
           .limit(limit)
    end
  end
end
