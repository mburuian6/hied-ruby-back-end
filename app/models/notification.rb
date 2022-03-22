class Notification < ApplicationRecord
  enum type: %i[other bid_accept bid_reject post_accepted_bid]
end
