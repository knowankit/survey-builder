# frozen_string_literal: true

# This model contains the question option schema and it belongs to question model
class QuestionOption < ApplicationRecord
  belongs_to :question
end
