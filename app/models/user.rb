class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]/.freeze
  VALID_NAME_REGEX = /\A[一-龥]+\z/.freeze
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  validates :nickname, presence: true
  validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }, confirmation: true
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'Full-width characters' }
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'Full-width characters' }
  validates :first_name_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX, message: 'Full-width katakana characters' }
  validates :last_name_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX, message: 'Full-width katakana characters' }
  validates :birthday, presence: true

  has_many :items
  has_many :orders
end
