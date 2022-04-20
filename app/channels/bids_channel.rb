class BidsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'bids'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
