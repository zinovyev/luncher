FactoryGirl.define do
  factory :price do
    item
    value { rand * 100 }
    date { Faker::Date.between(15.days.ago, 1.day.ago) }

    trait :today_price { date { Time.zone.today } }
  end
end
