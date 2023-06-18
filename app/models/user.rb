require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  has_many :surveys
  has_secure_password :password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def authenticate(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end