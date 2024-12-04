require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  context 'relationship' do
    it { is_expected.to have_many(:follows).class_name('Following') }
    it { is_expected.to have_many(:followees).class_name('Following') }
    it { is_expected.to have_many(:followers).class_name('User') }
    it { is_expected.to have_many(:followings).class_name('User') }
  end
end
