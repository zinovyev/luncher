class Order < ApplicationRecord
  belongs_to :user
  has_one :price
end
