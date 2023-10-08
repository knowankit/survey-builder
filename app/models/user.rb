# frozen_string_literal: true

# This model contains the User schema
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :surveys, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
end
