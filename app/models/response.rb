# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :user
  belongs_to :survey
end
