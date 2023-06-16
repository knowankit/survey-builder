class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions

  validates :name, presence: true
  validates :permalink, presence: true

end
