require 'rails_helper'

RSpec.describe Wall, type: :model do
  context 'associations' do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:posts).class_name('Post') }
  end
end
