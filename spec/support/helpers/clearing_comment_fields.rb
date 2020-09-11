shared_context "clear comment's fields" do
  before(:example) do
    @comment_clone = @comment.dup
    @comment.clear_fields
  end

  after(:example) do
    @comment.author_id = @comment_clone.author_id
    @comment.body = @comment_clone.body
  end
end
