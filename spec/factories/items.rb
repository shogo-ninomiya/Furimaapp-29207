FactoryBot.define do
  factory :item do
    name        { Faker::Name.initials(number: 2) }
    comment     { Faker::Lorem.sentence }
    price       { 2000 }
    category_id { 2 }
    status_id   { 2 }
    delivery_id { 2 }
    area_id     { 2}
    day_id      {2}
    user_id     {2}
    association :user
  end
end
