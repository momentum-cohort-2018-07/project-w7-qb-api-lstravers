class User < ApplicationRecord
  has_one_attached :photo
  has_many :questions
  has_many :answers
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end