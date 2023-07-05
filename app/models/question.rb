# frozen_string_literal: true

# This model contains the question schema and it belongs to Survey model
class Question < ApplicationRecord
  belongs_to :survey
  has_many :question_options, dependent: :destroy
end
