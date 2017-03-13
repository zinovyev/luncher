class Price < ApplicationRecord
  belongs_to :item, inverse_of: :prices
  belongs_to :organization, inverse_of: :prices
  has_many :orders
  delegate :title, :image_url, :course, to: :item
  alias_attribute :price, :value
  alias_attribute :image, :image_url
  before_save :update_date
  validates :value, presence: true

  private

  def update_date
    self.date ||= Time.zone.today
  end

  class << self
    def prices_for_organization(organization, date_from, date_to)
      Price
        .where(
          organization: organization,
          date: date_from..date_to)
        .eager_load(:item)
        .order('items.course')
    end

    def weekly_menu(organization)
      weekly_menu = WeeklyMenu::WeeklyMenu.new
      weekly_menu.prices = prices_for_organization(
        organization,
        weekly_menu.monday.date,
        weekly_menu.sunday.date
      )
      weekly_menu
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
