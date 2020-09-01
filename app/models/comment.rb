class Comment < ApplicationRecord
  belongs_to :author,      optional: true, class_name: :User
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
    update(author: nil, body: '[deleted]')
  end

  def deleted?
    author.nil?
  end
end
