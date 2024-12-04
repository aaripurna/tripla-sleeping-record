require 'rails_helper'

RSpec.describe ClockIn, type: :model do
  context "relations" do
    it { is_expected.to belong_to(:user) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:event_time) }
    it { is_expected.to validate_presence_of(:event_type) }
    it { is_expected.to validate_presence_of(:schedule_date) }
    it {
      create(:clock_in, event_type: :sleep_start)

      is_expected.to validate_uniqueness_of(:user_id).scoped_to(:event_type, :schedule_date)
    }
  end
end
