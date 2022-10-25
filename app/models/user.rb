# frozen_string_literal: true
require 'bcrypt'

class User < ApplicationRecord

  validates :name, uniqueness: true, presence: true 
  validates :email, uniqueness: true, presence: true 
  validates_presence_of :password_digest
  # validates_presence_of :password  

  has_secure_password

  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

end
