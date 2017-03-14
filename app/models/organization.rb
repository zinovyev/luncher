class Organization < ApplicationRecord
  has_many :users, inverse_of: :organization
  has_many :prices, inverse_of: :organization
  validates :title, presence: true, length: { minimum: 5, maximum: 30 }

  class << self
    def list_public(&_block)
      list = where(public: true)
      if block_given?
        list.each do |organization|
          yield organization
        end
      end
      list
    end
  end
end
