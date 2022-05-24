class Bid < ApplicationRecord
  belongs_to :post
  belongs_to :user, primary_key: :username, foreign_key: :username

  validates :pay, presence: true
  validates :pay, numericality: { greater_than: 0, message: '%{attribute} must be 0 or more' }
end
