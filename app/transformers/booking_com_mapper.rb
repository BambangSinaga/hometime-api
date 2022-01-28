class BookingComMapper < Dry::Transformer::Pipe
  import Dry::Transformer::HashTransformations

  define! do
    symbolize_keys
    unwrap :reservation
    unwrap :guest_details
    rename_keys number_of_guests: :guests
    rename_keys number_of_adults: :adults
    rename_keys number_of_children: :children
    rename_keys number_of_infants: :infants
    rename_keys status_type: :status
    rename_keys host_currency: :currency
    rename_keys expected_payout_amount: :payout_price
    rename_keys listing_security_price_accurate: :security_price
    rename_keys total_paid_amount_accurate: :total_price

    rename_keys guest_email: :email
    rename_keys guest_first_name: :first_name
    rename_keys guest_last_name: :last_name
    map_value :guest_phone_numbers, -> s { {first_phone_number: s.first, second_phone_number: s.last} }
    unwrap :guest_phone_numbers

    nest :guest, [:email, :first_name, :last_name, :first_phone_number, :second_phone_number]
  end

  def self.transform(payload)
    mapper = new
    record = mapper.(payload)
    ReservationStruct.new(record)
  end
end