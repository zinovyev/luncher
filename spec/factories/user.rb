FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    name { Faker::Name.name }
    username { Faker::Hipster.unique.word }
    organization { Organization.find(rand(2) + 2) }
  end
end
