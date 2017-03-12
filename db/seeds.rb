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
  5.times do |i|
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
