class Survey < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :permalink, presence: true

end
