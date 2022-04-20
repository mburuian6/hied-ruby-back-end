class BroadcastBidJob
  include Sidekiq::Job

  def perform(bid)
    BidsChannel.server.broadcast('bids_channel', bid)
  end
end
