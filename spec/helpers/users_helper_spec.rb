require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#full_name(user)' do
    let!(:user) { build(:user) }

    it "returns user's full name" do
      expect(helper.full_name(user))
        .to eq("#{ user.first_name } #{ user.last_name }")
    end
  end
end
