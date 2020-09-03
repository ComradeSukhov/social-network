class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :wall
  has_many   :comments, as: :commentable

  validates :body, :author_id, :wall_id, presence: true
end
