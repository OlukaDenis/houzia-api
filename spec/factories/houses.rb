FactoryBot.define do
  factory :house do
    name { Faker::Name.name }
    description { Faker::Quote.matz }
    image { 'me.com/image.png' }
    price { 4000 }
    user_id { nil }
  end
end