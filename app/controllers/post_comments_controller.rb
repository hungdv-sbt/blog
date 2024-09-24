class PostCommentsController < ApplicationController
  def create
    comment = PostComment.new(commment_params.merge(user_comment_id: current_user.id))

    return render json: {}, status: :bad_request unless comment.save

    @posts_comment = PostComment.where(post_id: params.dig(:comment, :post_id)).includes(:user).order(id: :desc).limit(5)
    body_html = render_to_string(:list_comment_post, layout: false)
    render json: { posts: body_html }, status: :ok
  end

  private

  def commment_params
    params.require(:comment).permit(:comment, :post_id)
  end
end
