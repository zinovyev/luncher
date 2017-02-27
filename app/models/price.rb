class Price < ApplicationRecord
  belongs_to :item
  has_many :orders

  class << self
    def for_today
      where(date: today)
    end

    private

    def today
      @today ||= Time.zone.today
    end
  end
end
