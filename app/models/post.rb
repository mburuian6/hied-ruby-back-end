class Post < ApplicationRecord
  has_many :bids, :dependent => :destroy
end
