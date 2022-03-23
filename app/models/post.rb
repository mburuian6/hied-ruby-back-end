class Post < ApplicationRecord
  has_one :post_link, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :rejected_bids, dependent: :destroy
  has_many :accepted_bids, dependent: :destroy
  belongs_to :user, foreign_key: 'username'

  scope :open_posts, -> { where(closed: false) }
  scope :closed_posts, -> { where(closed: true) }

  def mark_post_as_closed
    update(closed: true)
  end

end
