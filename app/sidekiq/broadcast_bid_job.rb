class BroadcastBidJob
  include Sidekiq::Job

  def perform(bid_id, job_hash_id)
    bid = Bid.find_by(id: bid_id)
    ActionCable.server.broadcast("bids_#{job_hash_id}", bid.attributes.except('id', 'post_id'))
  end
end
