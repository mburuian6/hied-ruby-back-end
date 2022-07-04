class Post < ApplicationRecord
  has_one :post_link, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :rejected_bids
  has_many :accepted_bids
  has_many_attached :images
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

  def save_coordinate(latitude, longitude)
    return unless physical?

    if coordinate
      coordinate.update({ latitude: latitude, longitude: longitude })
    else
      Coordinate.create({ post: self, longitude: longitude, latitude: latitude })
    end
  rescue StandardError => e
    @posts_logger.error("Error saving coordinates: #{e.message} \n "\
      "#{e.backtrace.join("\n\t")}")
  end

  def posts_logger
    @posts_logger ||= Logger.new("#{Rails.root}/log/posts_model_logger.log", 'daily')
  end

  # search
  def self.searchable_columns
    [:title, :description, :username, :start]
  end

  def search_term(term)
    Post.fuzzy_search({ title: term, description: term, username: term }, false)
  end
end
