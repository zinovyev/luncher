class Price < ApplicationRecord
  belongs_to :item, inverse_of: :prices
  has_many :orders
  delegate :title, :image_url, to: :item
  # TODO: add to migration
  before_save :update_date
  alias_attribute :price, :value
  alias_attribute :image, :image_url

  private

  def update_date
    self.date ||= Time.zone.today
  end

  class << self
    def weekly_menus(organization)
      weekly_menu = WeeklyMenu::WeeklyMenu.new
      prices = where(organization: organization, actual_at: weekly_menu.monday.date..weekly_menu.sunday.date)
      weekly_menu.prices = prices
    end

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
