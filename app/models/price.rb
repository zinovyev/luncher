class Price < ApplicationRecord
  belongs_to :item
  has_many :orders

  # TODO add to migration
  before_save :update_date
  # def initialize
    # date = Date.today
  # end

  private

  def update_date
    date = Date.today
  end

  class << self
    def for_today
      where(date: today)
    end 
   
    def available_items
      Item.where.not(id: taken_item_ids)
    end

    private

    def taken_item_ids
      Price.select('item_id').where('date >= :date', { date: Date.today }).map { |p| p.item_id }
    end

    def today
      @today ||= Time.zone.today
    end
  end
end
