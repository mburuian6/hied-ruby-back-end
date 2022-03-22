class AcceptedBid < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'owner'
end
