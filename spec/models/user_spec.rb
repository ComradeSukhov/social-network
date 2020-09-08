require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_one(:wall).class_name('Wall') }
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:comments).class_name('Comment') }
  end

  context 'validations' do
    subject { create(:user) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_length_of(:first_name).is_at_most(25) }
    it { should validate_length_of(:last_name).is_at_most(25) }
    it { should validate_length_of(:email).is_at_most(255) }
  end

  context 'when saved' do
    let(:user) { create(:user, email: Faker::Internet.unique.email.upcase) }

    it 'has email only in lowercase letters' do
      expect(user.email).to eq(user.email.downcase)
    end

    it 'has a wall' do
      expect(user.wall).to be_a(Wall)
    end
  end
end
