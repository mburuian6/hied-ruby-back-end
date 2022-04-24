class BroadcastBidJob
  include Sidekiq::Job

  def perform(bid_id, job_hash_id)
    bid = Bid.find_by(id: bid_id)
  end
end
