class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :created_at
  has_one :first_course
  has_one :main_course
  has_one :drink

  def created_at
    object.created_at.to_date
  end

  class PriceSerializer < ActiveModel::Serializer
    attributes :price, :title, :image
  end
end
