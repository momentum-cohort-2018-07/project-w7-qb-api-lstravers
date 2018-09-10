class Question < ApplicationRecord

  has_many :answers, dependent: :destroy
  validates :body, presence: true,
                    length: { minimum: 6 }

end
