class PartnerReservationIntegrator
  attr_accessor :errors

  def initialize(params)
    @params = params
    @errors = nil
  end

  def perform
    result = Airbnb.new.call(@params)
    return false if invalid?(result)

    record = AirbnbMapper.transform(result.values)

    ActiveRecord::Base.transaction do
      guest = Guest.find_or_initialize_by(email: record.guest.email)
      guest.update!(record.guest.attributes.except(:email))

      reservation = Reservation.find_or_initialize_by(code: record.code)
      reservation.update!(record.attributes.except(:code, :guest).merge(guest_id: guest.id))
    end

    true
  end

  private

  def invalid?(result)
    @errors = result.errors.to_h

    @errors.present?
  end
end
