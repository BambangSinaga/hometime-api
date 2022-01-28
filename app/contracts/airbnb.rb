
class Airbnb < ApplicationContract

  params do
    required(:reservation_code).filled(:string)
    required(:start_date).filled(:date)
    required(:end_date).filled(:date)
    required(:nights).filled(:integer)
    required(:guests).filled(:integer)
    required(:adults).filled(:integer)
    required(:children).filled(:integer)
    required(:infants).filled(:integer)
    required(:status).filled(:string)
    required(:guest).hash do
      required(:first_name).filled(:string)
      required(:last_name).filled(:string)
      required(:phone).filled(:string)
      required(:email).filled(:string)
    end
    required(:currency).filled(:string)
    required(:payout_price).filled(:string)
    required(:security_price).filled(:string)
    required(:total_price).filled(:string)
  end

  rule('guest.email').validate(:email_format)
end
