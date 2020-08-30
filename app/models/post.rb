class Post < ApplicationRecord
  belongs_to :user
  belongs_to :wall
  has_many :comments, as: :commentable

  validates :body, :user_id, :wall_id, presence: true
end
