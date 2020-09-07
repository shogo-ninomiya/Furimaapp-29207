class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image


  validates :name, presence: true
  validates :comment, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :delivery_id, presence: true
  validates :area_id, presence: true
  validates :day_id, presence: true


end
