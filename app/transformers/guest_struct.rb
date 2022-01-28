class GuestStruct < ApplicationStruct
  attribute :first_name, Types::String
  attribute :last_name, Types::String
  attribute :first_phone_number, Types::String
  attribute :email, Types::String
  attribute? :second_phone_number, Types::String.optional
end