class Bid < ApplicationRecord
  belongs_to :post
  belongs_to :user, primary_key: :username, foreign_key: :username

  validates :pay, presence: true
  validates :pay, numericality: { greater_than_or_equal_to: 0, message: ' must be 0 or more' }
end
