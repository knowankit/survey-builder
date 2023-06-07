class Survey < ApplicationRecord
  validates :name, presence: true
  validates :permalink, presence: true

end
