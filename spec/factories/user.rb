FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    image { 'me.com/image.png' }
    admin { false }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end