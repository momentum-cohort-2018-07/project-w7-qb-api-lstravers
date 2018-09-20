class Question < ApplicationRecord

  paginates_per 3

  has_many :answers, dependent: :destroy
  belongs_to :user
  #validates :body, presence: true,
  #                 length: { minimum: 6 }

end