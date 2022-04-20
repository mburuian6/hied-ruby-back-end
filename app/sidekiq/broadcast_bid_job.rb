class BroadcastBidJob
  include Sidekiq::Job

  def perform(bid)
    BidsChannel.server.broadcast('bids', bid)
  end
end
