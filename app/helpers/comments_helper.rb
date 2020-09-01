module CommentsHelper
  # Return parent_id for a specific comment
  # Check comments/_comment.html.haml for each variable description
  def reply_to_comment_id(comment, nesting_depth, nesting_limit)
    if nesting_limit.nil? || (nesting_depth < nesting_limit)
      comment.id
    else
      comment.parent_id
    end
  end
end
