RSpec.describe Following, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:following).class_name('User') }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:followee_id) }
  end
end
