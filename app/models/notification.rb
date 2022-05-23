# frozen_string_literal: true

require 'manage_hash_ids'
class Notification < ApplicationRecord
  enum notification_type: %i[other bid_accepted bid_rejected post_accepted_bid]

  belongs_to :user, primary_key: :username, foreign_key: :username

  after_create update_hash_id

  def update_hash_id
    update(hash_id: ManageHashIds.encode(id))
  end

end
