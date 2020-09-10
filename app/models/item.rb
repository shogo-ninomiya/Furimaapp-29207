class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :day
  belongs_to_active_hash :category
  belongs_to_active_hash :area

  VALID_PRICE_REGEX = /\A[-]?[0-9]+(\.[0-9]+)?\z/.freeze

  validates :name, presence: true
  validates :comment, presence: true
  validates :price, presence: true, numericality: { less_than_or_equal_to: 9_999_999, greater_than_or_equal_to: 300 }, format: { with: VALID_PRICE_REGEX }
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_id, presence: true
  validates :area_id, presence: true
  validates :day_id, presence: true
  validates :image, presence: true
end
