# frozen_string_literal: true

# This model contains the Survey schema and it belongs to User model
class Survey < ApplicationRecord
  extend FriendlyId
  friendly_id :permalink, use: :slugged

  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy

  validates :name, presence: true
  validates :permalink, presence: true, uniqueness: true
end
