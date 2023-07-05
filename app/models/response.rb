# frozen_string_literal: true

# This model contains the survey response schema and it belongs to User model and Survey
class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey
end
