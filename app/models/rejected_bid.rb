class RejectedBid < ApplicationRecord
  belongs_to :post
  belongs_to :user, primary_key: :username, foreign_key: :username
end
