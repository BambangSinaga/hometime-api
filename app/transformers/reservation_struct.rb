class ReservationStruct < ApplicationStruct
  attribute :code, Types::String
  attribute :start_date, Types::Date
  attribute :end_date, Types::Date
  attribute :nights, Types::Integer
  attribute :guests, Types::Integer
  attribute :adults, Types::Integer
  attribute :children, Types::Integer
  attribute :infants, Types::Integer
  attribute :status, Types::String
  attribute :currency, Types::String
  attribute :payout_price, Types::String
  attribute :security_price, Types::String
  attribute :total_price, Types::String
  attribute :guest, GuestStruct
end