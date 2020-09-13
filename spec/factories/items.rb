FactoryBot.define do
  factory :item do
    name        { 'サンプル' }
    comment     { 'sample' }
    price       { 2000 }
    category_id { 2 }
    status_id   {2}
    delivery_id {2}
    area_id     {2}
    day_id      {2}
    user_id     {2}
    association :user
  end
end
