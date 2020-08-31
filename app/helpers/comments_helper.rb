module CommentsHelper
  def reply_to_comment_id(comment, nesting, max_nesting)
    nesting < max_nesting ? comment.id : comment.parent_id
  end
end
