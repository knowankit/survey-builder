# frozen_string_literal: true

# This model contains the Survey schema and it belongs to User model
class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy

  validates :name, presence: true
  validates :permalink, presence: true, uniqueness: true
end
