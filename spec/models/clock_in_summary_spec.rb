require "rails_helper"

RSpec.describe ClockInSummary, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:schedule_date) }
    it { is_expected.to validate_presence_of(:user_id) }
    it {
      create(:clock_in_summary)
      is_expected.to validate_uniqueness_of(:schedule_date).scoped_to(:user_id)
    }
  end

  context "scopes" do
    describe ".followings_of" do
      include_context "followings sleep records"
      include_context "user sleep records"

      it "returns the followings sleep records" do
        records = ClockInSummary.followings_of(user.id).order(user_id: :desc, sleep_duration_minute: :desc)
        expect(records.size).to eq(6)
        expect(records[0].user_id).to eq(user_3.id)
        expect(records[1].user_id).to eq(user_3.id)
        expect(records[2].user_id).to eq(user_3.id)
        expect(records[3].user_id).to eq(user_2.id)
        expect(records[4].user_id).to eq(user_2.id)
        expect(records[5].user_id).to eq(user_2.id)
      end
    end
  end
end
