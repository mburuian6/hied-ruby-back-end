class RejectedBid < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'username'
end
