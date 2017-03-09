class Price < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :item, inverse_of: :prices
  has_many :orders
  delegate :title, :image_url, to: :item
  # TODO: add to migration
  before_save :update_date

  def attributes
    {
      value: value,
      title: title,
      image_url: image_url 
    }
  end

  private

  def update_date
    self.date ||= Time.zone.today
  end

  class << self
    def for_today(date = nil)
      date ||= today
      where('date = :today', today: date)
    end

    def available_items(date = nil)
      date ||= today
      taken_item_ids = for_today(date).map(&:item_id)
      Item.where.not(id: taken_item_ids)
    end

    private

    def today
      @today ||= Time.zone.today
    end
  end
end
