class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.find_by(closed: false)

    render json: PostSerializer.to_collection(@posts)
  end

  # GET /posts/1
  def show
    render json: PostSerializer.to_hal(@post)
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: PostSerializer.to_hal(@post), status: :created, location: @post
    else
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

  def mark_post_as_closed
    post_id = params[:postId]
    @post = Post.find(post_id)
    @post.update(closed: true)
    if @post.save
      render json: PostSerializer.to_hal(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def closed_posts; end

  def open_posts; end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :pay, :closed, :description, :start, :owner)
  end
end
