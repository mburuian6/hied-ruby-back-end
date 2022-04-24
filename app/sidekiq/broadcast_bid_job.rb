class BroadcastBidJob
  include Sidekiq::Job

  def perform(bid_id, job_hash_id)
    bid = Bid.find_by(id: bid_id)
    attributes = bid.attributes.except('id', 'post_id').merge(post_id: bid.post.hash_id)
    ActionCable.server.broadcast("bids_#{job_hash_id}", attributes)
  end
end
