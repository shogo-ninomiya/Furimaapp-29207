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
  validates :category_id, numericality: { other_than: 1, message: "can't be blank"  }
  validates :status_id, numericality: { other_than: 1, message: "can't be blank"  }
  validates :delivery_id, numericality: { other_than: 1, message: "can't be blank"  }
  validates :area_id, numericality: { other_than: 1, message: "can't be blank"  }
  validates :day_id, numericality: { other_than: 1, message: "can't be blank"  }
  validates :image, presence: true
end
