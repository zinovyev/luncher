require 'rails_helper'

RSpec.describe AggregateHelper, type: :helper do
  describe '#group_hash' do
    it 'groups a hash by a given key' do
      create_list(:item_with_prices, 2, prices_count: 6, course: Item::MAIN_COURSE)
      create_list(:item_with_prices, 5, prices_count: 3, course: Item::DRINK)
      create_list(:item_with_prices, 3, prices_count: 2, course: Item::FIRST_COURSE)
      prices = helper.group_hash(Price.all) { |price| price.item.course.to_sym }
      expect(prices[:main_course].count).to eq 12
      expect(prices[:drink].count).to eq 15
      expect(prices[:first_course].count).to eq 6 
    end
  end

  describe '#group_menu' do
    it 'groups menu items by course' do
      create_list(:item_with_prices, 2, prices_count: 6, course: Item::MAIN_COURSE)
      create_list(:item_with_prices, 5, prices_count: 3, course: Item::DRINK)
      create_list(:item_with_prices, 3, prices_count: 2, course: Item::FIRST_COURSE)
      prices = helper.group_menu(Price.all)
      expect(prices[:main_course].count).to eq 12
      expect(prices[:drink].count).to eq 15
      expect(prices[:first_course].count).to eq 6 
    end
  end
end
