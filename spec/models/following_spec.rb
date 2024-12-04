RSpec.describe Following, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:following).class_name('User') }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:followee_id) }

    context 'when follower and followee are the same user' do
      let(:user1) { create(:user) }
      subject { Following.new(follower_id: user1.id, followee_id: user1.id) }
      it 'returns error' do
        expect(subject).to be_invalid
        expect(subject.errors.added?(:follower_id, "must be differ from followee_id"))
      end
    end
  end
end
