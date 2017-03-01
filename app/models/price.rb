class Price < ApplicationRecord
  belongs_to :item
  has_many :orders

  # TODO add to migration
  before_save :update_date

  private

  def update_date
    self.date ||= Time.zone.today
  end

  class << self
    def for_today
      where('date >= :today', { today: today })
    end 
   
    def available_items
      taken_item_ids = for_today.map { |p| p.item_id }
      Item.where.not(id: taken_item_ids)
    end

    private

    def today
      @today ||= Time.zone.today
    end
  end
end
