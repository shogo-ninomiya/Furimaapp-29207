FactoryBot.define do
  factory :comment do
    text { 'test_comment' }
    association :user
    association :item
  end
end
