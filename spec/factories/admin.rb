FactoryBot.define do
  factory :admin, class: 'User' do
    username { Faker::Name.name }
    email { 'admin@gmail.com' }
    password { 'foobar' }
    admin { true }
    password_confirmation { 'foobar' }
    image { 'image.png'}
  end
end