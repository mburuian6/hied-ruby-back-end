class RejectedBidsController < ApplicationController
  before_action :set_rejected_bid, only: %i[ show update destroy ]
  load_and_authorize_resource

  # GET /rejected_bids
  def index
    @rejected_bids = RejectedBid.all

    render json: @rejected_bids
  end

  # GET /rejected_bids/1
  def show
    render json: @rejected_bid
  end

  # POST /rejected_bids
  def create
    @rejected_bid = RejectedBid.new(rejected_bid_params)

    if @rejected_bid.save
      render json: @rejected_bid, status: :created, location: @rejected_bid
    else
      render json: @rejected_bid.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rejected_bids/1
  def update
    if @rejected_bid.update(rejected_bid_params)
      render json: @rejected_bid
    else
      render json: @rejected_bid.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rejected_bids/1
  def destroy
    @rejected_bid.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rejected_bid
      @rejected_bid = RejectedBid.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rejected_bid_params
      params.require(:rejected_bid).permit(:pay, :notes, :post_id, :username)
    end
end
