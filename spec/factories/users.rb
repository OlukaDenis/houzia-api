FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { 'foo@bar.com' }
    image { 'me.com/image.png' }
    age { 21 }
    admin { false }
    password { 'foobar' }
  end
end