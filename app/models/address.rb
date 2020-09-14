class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :order
  belongs_to_active_hash :prefecture

  attr_accessor :token

  with_options presence: true: { "can't be blank" } do
    validates :post_code
    validates :prefecture_id: { other_than: 1 }
    validates :city
    validates :block
    validates :building
    validates :tellphone
    validates :order_id
  end

end
