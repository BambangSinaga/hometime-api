# frozen_string_literal: true

class Guest < ApplicationRecord

  has_many :reservations

  validates :email, :first_name, :last_name, :first_phone_number, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
