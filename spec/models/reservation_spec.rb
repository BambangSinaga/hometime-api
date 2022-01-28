RSpec.describe Reservation, type: :model do
  it {
    is_expected.to validate_presence_of(:code)
    is_expected.to validate_presence_of(:start_date)
    is_expected.to validate_presence_of(:end_date)
    is_expected.to validate_uniqueness_of(:code).case_insensitive
  }
end
