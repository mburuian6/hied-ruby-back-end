class Notification < ApplicationRecord
  enum type: %i[other bid_accept bid_reject post_accepted_bid]

  belongs_to :user, primary_key: :username, foreign_key: :username
end
