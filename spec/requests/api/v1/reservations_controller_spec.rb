RSpec.describe Api::V1::ReservationsController, type: :request do

  describe '#create' do
    context 'Airbnb' do
      let(:email) { "wayne_woodbridge@bnb.com" }
      let(:start_date) { "2021-04-14" }
      let(:end_date) { "2021-04-14" }
      let(:guests) { 4 }
      let(:request_body) do
        {
          "reservation_code": "YYY12345678",
          "start_date": start_date,
          "end_date": end_date,
          "nights": 5,
          "guests": guests,
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
        it 'returns 201 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :created
        end
      end

      context 'when email is invalid' do
        let(:email) { "wayne_woodbridge.com"}

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "not a valid email format"
        end
      end

      context 'when start_date is invalid' do
        let(:start_date) { "date"}

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "must be a date"
        end
      end

      context 'when end_date is invalid' do
        let(:end_date) { "date"}

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "must be a date"
        end
      end

      context 'when empty guests number' do
        let(:guests) { 0 }

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "must be greater than 0"
        end
      end
    end

    context 'BookingCom' do
      let(:email) { "wayne_woodbridge@booking.com" }
      let(:start_date) { "2021-03-12" }
      let(:end_date) { "2021-03-16" }
      let(:guests) { 4 }
      let(:request_body) do
        {
          "reservation": {
              "code": "XXX12345678",
              "start_date": start_date,
              "end_date": end_date,
              "expected_payout_amount": "3800.00",
              "guest_details": {
                  "localized_description": "4 guests",
                  "number_of_adults": 2,
                  "number_of_children": 2,
                  "number_of_infants": 0
              },
              "guest_email": email,
              "guest_first_name": "Wayne",
              "guest_last_name": "Woodbridge",
              "guest_phone_numbers": [
                  "639123456789",
                  "639123456789"
              ],
              "listing_security_price_accurate": "500.00",
              "host_currency": "AUD",
              "nights": 4,
              "number_of_guests": guests,
              "status_type": "accepted",
              "total_paid_amount_accurate": "4300.00"
          }
      }
      end

      context 'when contract is valid' do
        it 'returns 201 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :created
        end
      end

      context 'when email is invalid' do
        let(:email) { "wayne_woodbridge.com"}

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "not a valid email format"
        end
      end

      context 'when start_date is invalid' do
        let(:start_date) { "date"}

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "must be a date"
        end
      end

      context 'when end_date is invalid' do
        let(:end_date) { "date"}

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "must be a date"
        end
      end

      context 'when empty guests number' do
        let(:guests) { 0 }

        it 'returns 422 http code' do
          post api_v1_reservations_path,
          params: request_body

          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to include "must be greater than 0"
        end
      end
    end
  end
end
