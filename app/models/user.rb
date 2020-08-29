class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true, length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-\.]+@[a-z\d\-\.]+\.[a-z]+\z/i
  validates :email,   presence: true,
                    uniqueness: true,
                        length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX }

  before_save  { self.email = email.downcase }
  after_create { self.create_wall }

  has_one :wall
  has_many :posts
  has_many :comments
end
