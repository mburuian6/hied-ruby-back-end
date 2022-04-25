class Notification < ApplicationRecord
  enum notification_type: %i[other bid_accepted bid_rejected post_accepted_bid]

  belongs_to :user, primary_key: :username, foreign_key: :username
end
