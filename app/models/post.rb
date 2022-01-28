class Post < ApplicationRecord
  has_many :bids, dependent: :destroy
  has_many :rejected_bids, dependent: :destroy
end
