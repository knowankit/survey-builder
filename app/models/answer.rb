# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :question
  belongs_to :question_option, optional: true
end
