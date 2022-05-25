class Post < ApplicationRecord
  has_one :post_link, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :rejected_bids
  has_many :accepted_bids
  has_one :coordinate
  belongs_to :user, primary_key: :username, foreign_key: :username
  # belongs_to_model: foreign_key, has_many_model: primary_key

  enum location: %i[virtual physical]
  scope :open_posts, -> { where(closed: false) }
  scope :closed_posts, -> { where(closed: true) }

  validates :title, :pay, :start, :username, presence: true
  validates :pay, numericality: { greater_than_or_equal_to: 0, message: ' must be 0 or more' }

  def mark_post_as_closed
    update(closed: true)
  end

end
