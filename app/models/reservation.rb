# frozen_string_literal: true

class Reservation < ApplicationRecord

  belongs_to :guest

  validates :code, :start_date, :end_date, presence: true
  validates :code, uniqueness: { case_sensitive: false }
end
