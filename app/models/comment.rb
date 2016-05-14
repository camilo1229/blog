class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :body, presence: true
  validates :body, presence: true, length: {minimum: 20}
end