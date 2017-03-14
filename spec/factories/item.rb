FactoryGirl.define do
  factory :item do
    course { (rand * 3).to_i }
    photo nil
    sequence(:title) do |n|
      name = (course == 2 ? Faker::Beer.name : Faker::Food.ingredient)
      "#{name}-#{n}"
    end
    organization { Organization.find(rand(4) + 2) }

    factory :item_with_prices do
      transient do
        prices_count 5
      end

      after(:create) do |item, evaluator|
        create_list(:price, evaluator.prices_count, item: item)
      end
    end

    factory :item_with_date_prices do
      transient do
        prices_count 5
        prices_date Time.zone.today
      end

      after(:create) do |item, evaluator|
        create_list(
          :price,
          evaluator.prices_count,
          date: evaluator.prices_date,
          item: item
        )
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
