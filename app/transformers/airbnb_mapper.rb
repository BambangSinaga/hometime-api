class AirbnbMapper < Dry::Transformer::Pipe
  import Dry::Transformer::HashTransformations

  define! do
    symbolize_keys
    rename_keys reservation_code: :code

    unwrap :guest
    rename_keys phone: :first_phone_number
    copy_keys first_phone_number: :second_phone_number
    map_value :second_phone_number, -> s { nil }
    nest :guest, [:email, :first_name, :last_name, :first_phone_number, :second_phone_number]
  end

  def self.transform(payload)
    mapper = new
    record = mapper.(payload)
    ReservationStruct.new(record)
  end
end