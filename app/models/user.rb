# frozen_string_literal: true

require 'bcrypt'

# This model contains the User schema
class User < ApplicationRecord
  include BCrypt

  has_many :surveys, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  has_secure_password :password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def authenticate(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
