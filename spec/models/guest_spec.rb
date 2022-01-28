RSpec.describe Guest, type: :model do
  it {
    is_expected.to validate_presence_of(:email)
    is_expected.to validate_presence_of(:first_name)
    is_expected.to validate_presence_of(:last_name)
    is_expected.to validate_presence_of(:first_phone_number)
    is_expected.to validate_uniqueness_of(:email).case_insensitive
  }
end
