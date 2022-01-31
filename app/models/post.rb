class Post < ApplicationRecord
  has_one :post_link, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :rejected_bids, dependent: :destroy
  has_many :accepted_bids, dependent: :destroy

  def mark_post_as_closed
    update(closed: true)
  end

end
