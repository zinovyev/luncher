FactoryGirl.define do
  factory :item do
    course { (rand * 3).to_i }
    photo nil
    sequence(:title) do |n|
      name = (course == 2 ? Faker::Beer.name : Faker::Food.ingredient)
      "#{name}-#{n}"
    end

    factory :item_with_prices do
      transient do
        prices_count 5
        prices_organization { Organization.find(rand(2) + 2) }
      end

      after(:create) do |item, evaluator|
        create_list(:price,
                    evaluator.prices_count,
                    organization: evaluator.prices_organization,
                    item: item)
      end
    end

    factory :item_with_date_prices do
      transient do
        prices_count 5
        prices_date Time.zone.today
        prices_organization { Organization.find(rand(2) + 2) }
      end

      after(:create) do |item, evaluator|
        create_list(
          :price,
          evaluator.prices_count,
          date: evaluator.prices_date,
          organization: evaluator.prices_organization,
          item: item
        )
      end
    end

    factory :item_with_today_prices do
      transient do
        prices_count 5
        prices_organization { Organization.find(rand(2) + 2) }
      end

      after(:create) do |item, evaluator|
        create_list(:price,
                    evaluator.prices_count,
                    :today_price,
                    organization: evaluator.prices_organization,
                    item: item)
      end
    end
  end
end
