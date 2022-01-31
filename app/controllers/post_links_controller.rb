class PostLinksController < ApplicationController
  before_action :set_post_link, only: %i[ show update destroy ]

  # GET /post_links
  def index
    @post_links = PostLink.all

    render json: @post_links
  end

  # GET /post_links/1
  def show
    render json: @post_link
  end

  # POST /post_links
  def create
    @post_link = PostLink.new(post_link_params)

    if @post_link.save
      render json: @post_link, status: :created, location: @post_link
    else
      render json: @post_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /post_links/1
  def update
    if @post_link.update(post_link_params)
      render json: @post_link
    else
      render json: @post_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post_links/1
  def destroy
    @post_link.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_link
      @post_link = PostLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_link_params
      params.require(:post_link).permit(:domain, :path, :post_marker, :post_id)
    end
end
