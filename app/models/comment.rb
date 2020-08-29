class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name:'Comment'

  def comments
    # Returns an array of comments of a particular object
    Comment.where(commentable: commentable, parent_id: id)
  end
end
