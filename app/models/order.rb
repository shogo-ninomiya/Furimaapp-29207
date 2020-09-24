class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :adress

  attr_accessor :token
end
