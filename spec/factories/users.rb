FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { 'foo@bar.com' }
    image { 'me.com/image.png' }
    age { 21 }
    password { 'foobar' }
  end
end