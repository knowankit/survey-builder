# frozen_string_literal: true


# This model contains the User schema
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :surveys, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  attr_accessor :password, :password_confirmation
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
end
