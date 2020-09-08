require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:wall).class_name('Wall') }
    it { should have_many(:comments).class_name('Comment') }
  end

  context 'validations' do
    subject do
      user = create(:user)
      user.posts.create(attributes_for(:post, wall_id: user.wall.id))
    end

    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:wall_id) }
  end
end
