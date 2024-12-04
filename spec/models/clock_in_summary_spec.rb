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
end
