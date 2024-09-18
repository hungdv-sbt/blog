class PostController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = Post.all
    items = params[:items_each_page].present? ? params[:items_each_page] : Post::DEFAULT_ITEMS_EACH_PAGE

    @q = posts.ransack(params[:q])
    results = @q.result
    @pagy, @posts = pagy(results, items: items)
  end

  def new
  end

  def create
    post = Post.new(post_params.merge(user_id: current_user.id))
    return redirect_to posts_path if post.save

    redirect_to :back
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :status, :image)
  end
end
