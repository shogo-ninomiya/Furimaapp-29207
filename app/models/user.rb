class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
VALID_PASSWORD_REGEX =/\A[a-z0-9]+\z/i

validates :nickname, presence: true
validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX }, confirmation: true
validates :first_name, presence: true
validates :last_name, presence: true
validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
validates :birthday, presence: true


end
