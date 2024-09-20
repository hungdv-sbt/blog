class PostController < ApplicationController
  before_action :redirect_to_back_home, only: %i[new create edit update posts_list destroy]
  before_action :set_post, only: %i[edit update show destroy]
  before_action :authorize_post, only: %i[edit update]

  def index
    @q = Post.publish_post.includes(:image_attachment).ransack(params[:q])
    items = params[:items_each_page].present? ? params[:items_each_page] : Post::DEFAULT_ITEMS_EACH_PAGE
    results = @q.result
    @pagy, @posts = pagy(results, items: items)
  end

  def new
  end

  def create
    status = params.dig(:post, :status).to_i
    post = Post.new(post_params.merge({ user_id: current_user.id, status: status }))
    return redirect_to posts_list_path if post.save

    redirect_to :back
  end

  def posts_list
    posts_of_user = Post.all.where(user_id: current_user.id).includes(:image_attachment)
    items = params[:items_each_page].present? ? params[:items_each_page] : Post::DEFAULT_ITEMS_EACH_PAGE

    @pagy, @posts = pagy(posts_of_user, items: items)
  end

  def edit
  end

  def show
  end

  def update
    status = params.dig(:post, :status).to_i
    return redirect_to posts_list_path if @post.update(post_params.merge({ user_id: current_user.id, status: status }))

    redirect_to post_index_path
  end

  def destroy
    return redirect_to posts_list_path if @post.destroy

    redirect_to post_index_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

  def authorize_post
    authorize @post
  end

  def redirect_to_back_home
    return redirect_to posts_path if current_user.blank?
  end
end
