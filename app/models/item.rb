class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image


  VALID_PRICE_REGEX = /\A[-]?[0-9]+(\.[0-9]+)?\z/

  validates :name, presence: true
  validates :comment, presence: true
  validates :price, presence: true, :numericality => {  :less_than_or_equal_to => 9999999,:greater_than_or_equal_to => 300 }, format: { with: VALID_PRICE_REGEX }
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_id, presence: true
  validates :area_id, presence: true
  validates :day_id, presence: true
  validates :image, presence: true

end
