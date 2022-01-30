require 'manage_hash_ids'
class BidsController < ApplicationController
  before_action :set_bid, only: %i[ show update destroy ]

  # GET /bids
  def index
    @bids = Bid.all

    render json: @bids
  end

  # GET /bids/1
  def show
    render json: @bid
  end

  # POST /bids
  def create
    @bid = Bid.new(bid_params)
    potential_bid = Bid.find_by(owner: @bid.owner, post_id: @bid.post_id)
    if potential_bid
      if potential_bid.update(pay: @bid.pay, notes: @bid.notes)
        render json: BidSerializer.to_hal(potential_bid)
      else
        render json: potential_bid.errors, status: :unprocessable_entity
      end
      return
    end

    if @bid.save
      @bid.update(hash_id: ManageHashIds.encode_bid(@bid.id))
      render json: BidSerializer.to_hal(@bid), status: :created, location: @bid
    else
      render json: @bid.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bids/1
  def update
    if @bid.update(bid_params)
      render json: BidSerializer.to_hal(@bid)
    else
      render json: @bid.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bids/1
  def destroy
    @bid.destroy
  end

  def open_post_bids
    post = params[:post_id]
    bids = Bid.where(post_id: post)
    render json: BidSerializer.to_collection(bids)
  end

  def accept_bid
    post = Post.find(params[:post_id])
    accepted_bid_id = params[:bid_id]
    bids = post.bids
    bids.each do |bid|
      if bid.id.to_s == accepted_bid_id
        bid.accepted = true
        create_accepted_bid(bid.attributes)
        bid_notification = create_accept_notifications(bid)
        create_post_notifications(bid, bid_notification)
      else
        create_rejected_bid(bid.attributes)
        create_rejection_notifications(bid)
      end
      Bid.destroy(bid.id)
    end
    post.mark_post_as_closed
    render json: nil, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bid
    @bid = Bid.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bid_params
    params.require(:bid).permit(:pay, :notes, :post_id, :owner)
  end

  def create_bid_notifications(bid)
    Notification.create(
      subject: "Bid for Post #{bid.post.hash_id} accepted",
      message: "Your bid for post titled #{bid.post.title}, marker: #{bid.post.hash_id} has "\
          "been accepted. Please contact #{bid.post.owner} for arrangements",
      owner: bid.owner
    )
  end

  def create_post_notifications(bid, bid_notification)
    post_notification = Notification.create(
      subject: "Accepted bid for Post #{bid.post.hash_id}",
      message: "You have successfully accepted the bid for post title #{bid.post.title}, marker: #{bid.post.hash_id}; "\
          "Please contact #{bid.post.title} for arrangements",
      owner: bid.post.owner,
      notification_references: [bid_notification.id]
    )
    bid_notification.update(notification_references: [post_notification.id])
  end

  def create_rejection_notifications(bid)
    Notification.create(
      subject: "Bid for Post #{bid.post.hash_id} rejected",
      message: "Your bid for post titled #{bid.post.title}, marker: #{bid.post.hash_id} has "\
          "been rejected. We wish you better luck next time!",
      owner: bid.owner
    )
  end

  def create_accepted_bid(attributes)
    AcceptedBid.create(
      attributes.except('accepted', 'id', 'created_at', 'updated_at')
    )
  end

  def create_rejected_bid(attributes)
    RejectedBid.create(
      attributes.except('accepted', 'id', 'created_at', 'updated_at')
    )
  end
end
