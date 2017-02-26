class Price < ApplicationRecord
  belongs_to :item
  has_many :orders
end
