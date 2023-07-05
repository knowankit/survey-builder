# frozen_string_literal: true

# This model contains the refresh token schema and it belongs to User model
class RefreshToken < ApplicationRecord
  belongs_to :user
end
