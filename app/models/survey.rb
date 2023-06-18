class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :responses

  validates :name, presence: true
  validates :permalink, presence: true, uniqueness: true

end
