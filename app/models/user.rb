class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]/.freeze
  VALID_NAME_REGEX = /\A[一-龥]+\z/.freeze
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :password, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }, confirmation: true
    validates :first_name, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'は全角で入力してください' }
    validates :first_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :last_name_kana, format: { with: VALID_NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end

  has_many :items
  has_many :orders
  has_many :comments
end
