class Comment < ApplicationRecord
  belongs_to :user,        optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent,      optional: true, class_name:'Comment'

  validates :body, presence: true

  # Return child comments for particular comment
  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  # Clear some comment' fields (using in comments#destroy)
  #   because a comment must not be completely removed from a thread
  def clear_fields
    update(user: nil, body: '[deleted]')
  end

  def deleted?
    user.nil?
  end
end
