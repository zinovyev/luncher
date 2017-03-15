# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

default = Organization.create(id: 1, title: 'Default', public: false)
google = Organization.create(id: 2, title: 'Google')
yandex = Organization.create(id: 3, title: 'Yandex')
meduza = Organization.create(id: 4, title: 'Meduza')

admin = User.create(
  name: 'admin',
  username: 'admin',
  email: 'admin@example.com',
  organization: default,
  password: 'password'
)

[google, yandex, meduza].each do |organization|
  3.times do |i|
    name = Faker::Name.name
    User.create(
      name: name,
      username: Faker::Internet.user_name(name),
      email: Faker::Internet.email(name),
      organization: organization,
      password: 'password'
    )
  end
end

items = []
20.times do |i|
  items << Item.create(
    title: Faker::Food.ingredient,
    course: rand(3).ceil,
    image: Faker::LoremPixel.image("150x150", false, 'food', (rand(10) + 1)),
  )
end

weekly_menu = WeeklyMenu::WeeklyMenu.new
prices = []
5.times do |i|
  prices << Price.create(
    item: items.sample,
    organization: Organization.list_public.sample,
    value: Faker::Number.decimal(5, 2),
    date: weekly_menu.days.values.map(&:date).sample
  )
end
