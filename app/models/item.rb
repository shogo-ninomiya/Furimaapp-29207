class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_many :comments
  has_one :order
  has_one_attached :image
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :day
  belongs_to_active_hash :category
  belongs_to_active_hash :area

  def self.search(search)
    if search != ""
      Item.where('name LIKE ?', "%#{search}%")
    else
      Item.all
    end
  end

  VALID_PRICE_REGEX = /\A[-]?[0-9]+(\.[0-9]+)?\z/.freeze

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :delivery_id
    validates :area_id
    validates :day_id
  end

  with_options presence: true do
    validates :name
    validates :comment
    validates :price, numericality: { less_than_or_equal_to: 9_999_999, greater_than_or_equal_to: 300 }, format: { with: VALID_PRICE_REGEX }
    validates :image
  end
  
end
