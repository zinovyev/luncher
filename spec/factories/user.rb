FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    name { Faker::Name.name }
    username { Faker::Hipster.word }
  end
end
