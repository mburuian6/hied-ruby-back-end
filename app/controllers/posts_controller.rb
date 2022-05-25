require 'manage_hash_ids'
class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  skip_before_action :doorkeeper_authorize!, only: [:index]
  load_and_authorize_resource

  # GET /posts
  def index
    @posts = Post.open_posts
    render json: PostSerializer.to_collection(@posts)
  end

  # GET /posts/1
  def show
    render json: PostSerializer.to_hal(@post)
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    latitude = params[:latitude]
    longitude = params[:longitude]
    if @post.save
      @post.update(hash_id: ManageHashIds.encode(@post.id))
      PostLink.create({
                        domain: Rails.application.credentials.domain,
                        path: '/post_link',
                        post_marker: @post.hash_id,
                        post_id: @post.id
                      })
      @post.save_coordinate(latitude, longitude)
      render json: PostSerializer.to_hal(@post), status: :created, location: @post
    else
      logger.error("Error: #{@post.errors.full_messages.to_sentence.downcase}")
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: PostSerializer.to_hal(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def closed_posts;
    username = params[:username]
    @posts = Post.closed_posts.where(username: username)
    render json: PostSerializer.to_collection(@posts)
  end

  def open_posts;
    username = params[:username]
    @posts = Post.open_posts.where(username: username)
    render json: PostSerializer.to_collection(@posts)
  end

  def locations
    render json: Post.locations
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :pay, :closed, :description, :start, :username, :location, images: [])
  end

  def posts_logger
    @posts_logger ||= Logger.new("#{Rails.root}/log/posts_logger.log", 'daily')
  end
end
