FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { 'admin@gmail.com' }
    image { 'me.com/image.png' }
    admin { true }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end