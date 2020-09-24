FactoryBot.define do
  factory :order_address do
    post_code { '111-1111' }
    prefecture_id { 5 }
    city { '立川市' }
    block { '1-1' }
    building { '東京ハイツ' }
    tellphone { '09090909090' }
    token { 'qawsdefrgthyjuiko1234567' }
    association :user
    association :item
  end
end
