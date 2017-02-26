class Price < ApplicationRecord
  has_one :item
  has_many :orders
end
