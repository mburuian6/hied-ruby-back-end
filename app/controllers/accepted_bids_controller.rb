class AcceptedBidsController < ApplicationController
  before_action :set_accepted_bid, only: %i[ show update destroy ]

  # GET /accepted_bids
  def index
    @accepted_bids = AcceptedBid.all

    render json: @accepted_bids
  end

  # GET /accepted_bids/1
  def show
    render json: @accepted_bid
  end

  # POST /accepted_bids
  def create
    @accepted_bid = AcceptedBid.new(accepted_bid_params)

    if @accepted_bid.save
      render json: @accepted_bid, status: :created, location: @accepted_bid
    else
      render json: @accepted_bid.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accepted_bids/1
  def update
    if @accepted_bid.update(accepted_bid_params)
      render json: @accepted_bid
    else
      render json: @accepted_bid.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accepted_bids/1
  def destroy
    @accepted_bid.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accepted_bid
      @accepted_bid = AcceptedBid.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def accepted_bid_params
      params.require(:accepted_bid).permit(:pay, :notes, :post_id, :owner)
    end
end
