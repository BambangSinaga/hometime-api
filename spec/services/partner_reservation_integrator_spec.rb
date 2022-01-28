RSpec.describe PartnerReservationIntegrator, type: :service do

  describe '#perform' do
    let(:email) { "wayne_woodbridge@bnb.com" }
    let(:start_date) { "2021-05-12" }
    let(:end_date) { "2021-05-16" }
    let(:reservation_code) { 'YYY12345678' }
    let(:request_body) do
      {
        "reservation_code": reservation_code,
        "start_date": start_date,
        "end_date": end_date,
        "nights": 5,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": email
        },
        "currency": "AUD",
        "payout_price": "4200.00",
        "security_price": "500",
        "total_price": "4700.00"
      }
    end

    context 'when contract is valid' do
      context 'when reservation not exists' do
        it 'returns true' do
          result = described_class.new(request_body).perform

          expect(result).to eql true

          expect(Guest.count).to eql 1
          expect(Reservation.count).to eql 1

          guest = Guest.first
          expect(guest.email).to eql request_body[:guest][:email]
          expect(guest.first_phone_number).to eql request_body[:guest][:phone]
          expect(guest.first_name).to eql request_body[:guest][:first_name]
          expect(guest.last_name).to eql request_body[:guest][:last_name]

          reservation = Reservation.first
          expect(reservation.code).to eql request_body[:reservation_code]
          expect(reservation.start_date).to eql request_body[:start_date].to_date
          expect(reservation.end_date).to eql request_body[:end_date].to_date
          expect(reservation.nights).to eql request_body[:nights]
          expect(reservation.guests).to eql request_body[:guests]
          expect(reservation.adults).to eql request_body[:adults]
          expect(reservation.children).to eql request_body[:children]
          expect(reservation.infants).to eql request_body[:infants]
          expect(reservation.status).to eql request_body[:status]
          expect(reservation.currency).to eql request_body[:currency]
          expect(reservation.payout_price).to eql request_body[:payout_price]
          expect(reservation.security_price).to eql request_body[:security_price]
          expect(reservation.total_price).to eql request_body[:total_price]
        end
      end

      context 'when reservation exists' do
        let(:email) { 'bams@mail.co' }
        let!(:guest) { Guest.create(email: email, first_name: 'Bambang', last_name: 'Sinaga', first_phone_number: '0394823') }
        let!(:reservation) do
          Reservation.create(code: 'wom4308r4jfj4JW3', start_date: '2021-05-12', end_date: '2021-05-14')
        end

        it 'returns true' do
          result = described_class.new(request_body).perform

          expect(result).to eql true

          expect(Guest.count).to eql 1
          expect(Reservation.count).to eql 1

          guest = Guest.first
          expect(guest.email).to eql email
          expect(guest.first_phone_number).to eql request_body[:guest][:phone]
          expect(guest.first_name).to eql request_body[:guest][:first_name]
          expect(guest.last_name).to eql request_body[:guest][:last_name]

          reservation = Reservation.first
          expect(reservation.code).to eql reservation_code
          expect(reservation.start_date).to eql request_body[:start_date].to_date
          expect(reservation.end_date).to eql request_body[:end_date].to_date
          expect(reservation.nights).to eql request_body[:nights]
          expect(reservation.guests).to eql request_body[:guests]
          expect(reservation.adults).to eql request_body[:adults]
          expect(reservation.children).to eql request_body[:children]
          expect(reservation.infants).to eql request_body[:infants]
          expect(reservation.status).to eql request_body[:status]
          expect(reservation.currency).to eql request_body[:currency]
          expect(reservation.payout_price).to eql request_body[:payout_price]
          expect(reservation.security_price).to eql request_body[:security_price]
          expect(reservation.total_price).to eql request_body[:total_price]
        end
      end
    end

    context 'when email is invalid' do
      let(:email) { "wayne_woodbridge.com"}

      it 'returns false' do
        result = described_class.new(request_body).perform

        expect(result).to eql false
      end
    end

    context 'when start_date is invalid' do
      let(:start_date) { "date"}

      it 'returns 422 http code' do
        result = described_class.new(request_body).perform

        expect(result).to eql false
      end
    end

    context 'when end_date is invalid' do
      let(:end_date) { "date"}

      it 'returns 422 http code' do
        result = described_class.new(request_body).perform

        expect(result).to eql false
      end
    end
  end
end
