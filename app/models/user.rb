# frozen_string_literal: true
require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :name, uniqueness: true, presence: true 
  validates :email, uniqueness: true, presence: true 
  validates_presence_of :password_digest

  has_secure_password

  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

end
