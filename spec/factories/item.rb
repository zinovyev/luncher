FactoryGirl.define do
  factory :item do
    course { (rand() * 3).to_i }
    title { course == 2 ? Faker::Beer.name : Faker::Food.ingredient }
    photo nil

    factory :item_with_prices do
      transient do
        prices_count 5
      end

      after(:create) do |item, evaluator|
        create_list(:price, evaluator.prices_count, item: item)
      end
    end

    factory :item_with_today_prices do
      transient do
        prices_count 5
      end

      after(:create) do |item, evaluator|
        create_list(:price, evaluator.prices_count, :today_price, item: item)
      end
    end
  end
end
