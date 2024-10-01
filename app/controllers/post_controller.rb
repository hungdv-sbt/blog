class PostController < ApplicationController
  before_action :set_post, only: %i[edit update show destroy]
  before_action :authorize_post, only: %i[edit update destroy]
  before_action :conver_status_string_to_integer, only: %i[create update]

  def index
    @q = Post.publish_post.eager_load_photos.includes(:user).ransack(params[:q])
    results = @q.result
    @pagy, @posts = pagy(results, items: ApplicationRecord::DEFAULT_ITEMS_EACH_PAGE)
  end

  def new
  end

  def create
    post = current_user.posts.new(post_params.merge(status: @status_id))
    return redirect_to list_post_index_path if post.save

    redirect_to :back
  end

  def my_posts
    @q = current_user.posts.eager_load_photos.includes(:user).ransack(params[:q])
    results = @q.result
    @pagy, @posts = pagy(results, items: ApplicationRecord::DEFAULT_ITEMS_EACH_PAGE)
  end

  def edit
  end

  def show
    @comments = @post.post_comments.eager_load_photos.includes(:user).order(created_at: :desc).limit(5)
  end

  def update
    return redirect_to list_post_index_path if @post.update(post_params.merge(status: @status_id))

    redirect_to post_index_path
  end

  def destroy
    return redirect_to list_post_index_path if @post.destroy

    redirect_to post_index_path
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def conver_status_string_to_integer
    @status_id = params.dig(:post, :status).to_i
  end

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

  def authorize_post
    authorize @post
  end
end
