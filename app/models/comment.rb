class Comment < ApplicationRecord
  belongs_to :user,        optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent,      optional: true, class_name:'Comment'

  validates :body, presence: true

  # Return child comments for particular comment
  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  # Comments must not dissappear from threads
  #   therefore comments must not be destroyed
  #   but must have some fields cleared
  def clear_fields
    update(user: nil, body: '[deleted]')
  end

  def deleted?
    user.nil?
  end
end
