require 'manage_hash_ids'
class BidsController < ApplicationController
  before_action :set_bid, only: %i[ show update destroy ]
  load_and_authorize_resource

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
    potential_bid = Bid.find_by(username: @bid.username, post_id: @bid.post_id)
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
        accepted_bid = create_accepted_bid(bid)
        bid_notification = create_accept_notifications(accepted_bid)
        create_post_notifications(accepted_bid, bid_notification)
      else
        rejected_bid = create_rejected_bid(bid)
        create_rejection_notifications(rejected_bid)
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
    params.require(:bid).permit(:pay, :notes, :post_id, :username)
  end

  def create_accept_notifications(accepted_bid)
    Notification.create(
      username: accepted_bid.username,
      type: :bid_accept,
      data: {
        bid: accepted_bid.hash_id,
        post: accepted_bid.post.hash_id,
        post_title: accepted_bid.post.title,
        post_username: accepted_bid.post.username,
        time: accepted_bid.created_at
      }
    )
  end

  def create_post_notifications(accepted_bid, bid_notification)
    Notification.create(
      username: accepted_bid.post.username,
      type: :post_accepted_bid,
      notification_references: [{bid_accepted: bid_notification.id}],
      data: {
        bid: accepted_bid.hash_id,
        post: accepted_bid.post.hash_id,
        post_title: accepted_bid.post.title,
        post_username: accepted_bid.post.username,
        time: accepted_bid.created_at
      }
    )
    bid_notification.update(notification_references: [post_notification.id])
  end

  def create_rejection_notifications(rejected_bid)
    Notification.create(
      username: rejected_bid.username,
      type: :bid_reject,
      data: {
        bid: rejected_bid.hash_id,
        post: rejected_bid.post.hash_id,
        post_title: rejected_bid.post.title,
        time: rejected_bid.created_at
      }
    )
  end

  def create_accepted_bid(bid)
    AcceptedBid.create(
      bid.attributes
        .except('accepted', 'id', 'created_at', 'updated_at')
        .merge(original_bid_created: bid.created_at, original_bid_updated: bid.updated_at)
    )
  end

  def create_rejected_bid(bid)
    RejectedBid.create(
      bid.attributes
         .except('accepted', 'id', 'created_at', 'updated_at')
         .merge(original_bid_created: bid.created_at, original_bid_updated: bid.updated_at)
    )
  end
end
