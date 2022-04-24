class BidsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bids_#{params[:job_hash_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # Get from /cable
    # Do something
    # Broadcast to everyone subscribed
    bid = Bid.find(data['id'])
    ActionCable.server.broadcast('bids', bid)
  end
end
