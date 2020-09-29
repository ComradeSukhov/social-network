require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#full_name(user)' do
    let!(:user) { build(:user, first_name: 'John', last_name: 'Wick') }

    it "returns user's full name" do
      expect(helper.full_name(user)).to eq('John Wick')
    end
  end
end
