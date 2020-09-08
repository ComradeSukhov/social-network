require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:context) do
    @user    = create(:user)
    @post    = @user.posts.create(attributes_for(:post, wall_id: @user.wall.id))
    @comment = @post.comments.create(attributes_for(:comment,
                                                      author_id: @user.id))
  end

  after(:context) do
    @comment.destroy
    @post.destroy
    @user.wall.destroy
    @user.destroy
  end

  context 'associations' do
    it { should belong_to(:author).class_name('User').optional }
    it { should belong_to(:commentable) }
    it { should belong_to(:parent).class_name('Comment').optional }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe '#comments' do
    context 'when a comment has no child comments' do
      it 'returns an empty array' do
        expect(@comment.comments).to be_empty
      end
    end

    context 'when a comment has some child comments' do
      before(:example) do
        rand(3..150).times do
          @comment.comments
                  .create(attributes_for(:comment,
                                          author_id: @comment.author.id))
        end
      end

      it 'returns an array of child comments' do
        @comment.comments.each do |child|
          expect(child).to be_a(Comment)
          expect(child.parent_id).to eq(@comment.id)
        end
      end
    end
  end

  describe '#clear_fields' do
    before(:example) do
      @comment_clone = @comment.dup
      @comment.clear_fields
    end

    after(:example) do
      @comment.author_id = @comment_clone.author_id
      @comment.body = @comment_clone.body
    end

    it "changes some comment's fields" do
      expect(@comment.author_id).to be_nil
      expect(@comment.body).to eq('[deleted]')
    end
  end

  describe '#deleted?' do
    context 'when comment is not deleted' do
      it 'returns false' do
        expect(@comment.deleted?).to be(false)
      end
    end

    context 'when comment is deleted' do
      before(:example) do
        @comment_clone = @comment.dup
        @comment.clear_fields
      end

      after(:example) do
        @comment.author_id = @comment_clone.author_id
        @comment.body = @comment_clone.body
      end

      it 'returns true' do
        expect(@comment.deleted?).to be(true)
      end
    end
  end
end
