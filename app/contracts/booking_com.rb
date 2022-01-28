class BookingCom < ApplicationContract

  params do
    required(:reservation).hash do
      required(:code).filled(:string)
      required(:start_date).filled(:date)
      required(:end_date).filled(:date)
      required(:expected_payout_amount).filled(:string)
      required(:guest_details).hash do
        required(:localized_description).filled(:string)
        required(:number_of_adults).filled(:integer)
        required(:number_of_children).filled(:integer)
        required(:number_of_infants).filled(:integer)
      end
      required(:guest_email).filled(:string)
      required(:guest_first_name).filled(:string)
      required(:guest_last_name).filled(:string)
      required(:guest_phone_numbers).array(:str?)
      required(:listing_security_price_accurate).filled(:string)
      required(:host_currency).filled(:string)
      required(:nights).filled(:integer)
      required(:number_of_guests).filled(:integer, gt?: 0)
      required(:status_type).filled(:string)
      required(:total_paid_amount_accurate).filled(:string)
    end
  end

  rule('reservation.guest_email').validate(:email_format)
end
