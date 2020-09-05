class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
VALID_PASSWORD_REGEX =/\A[a-z0-9]+\z/i

validates :nickname, presence: true
validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }, confirmation: true
validates :first_name, presence: true, format: { with: /\A[一-龥]+\z/, message: 'Full-width characters'}
validates :last_name, presence: true, format: { with: /\A[一-龥]+\z/, message: 'Full-width characters'}
validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'Full-width characters'}
validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'Full-width characters'}
validates :birthday, presence: true


end
