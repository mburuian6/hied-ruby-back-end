class Post < ApplicationRecord
  has_one :post_link, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :rejected_bids
  has_many :accepted_bids
  belongs_to :user, primary_key: :username, foreign_key: :username
  # belongs_to_model: foreign_key, has_many_model: primary_key

  scope :open_posts, -> { where(closed: false) }
  scope :closed_posts, -> { where(closed: true) }

  def mark_post_as_closed
    update(closed: true)
  end

end
