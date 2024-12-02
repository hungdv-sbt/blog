class PostCommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  before_action :post_comment_limit_five, only: %i[create update remove_image destroy]

  def create
    comment = PostComment.new(comment_params.merge(user_comment_id: current_user.id))

    return render json: {}, status: :bad_request unless comment.save

    body_html = render_to_string(:list_comment_post, layout: false)
    render json: { posts: body_html }, status: :ok
  end

  def update
    return render json: {}, status: :bad_request unless @comment.update(comment_params)

    body_html = render_to_string(:list_comment_post, layout: false)
    render json: { posts: body_html }, status: :ok
  end

  def destroy
    return render json: {}, status: :bad_request unless @comment.destroy

    body_html = render_to_string(:list_comment_post, layout: false)
    render json: { posts: body_html }, status: :ok
  end

  def remove_image
    image = ActiveStorage::Attachment.find_by(record_id: params[:record_id].to_i, record_type: 'PostComment')
    return render json: { error: 'image_blank' }, status: :bad_request if image.blank?

    return render json: { error: 'remove_fail' }, status: :bad_request unless image.destroy

    body_html = render_to_string(:list_comment_post, layout: false)
    render json: { posts: body_html }, status: :ok
  end

  private

  def post_comment_limit_five
    @posts_comment = PostComment.eager_load_photos.where(post_id: params.dig(:comment, :post_id)).includes(:user).order(id: :desc).limit(5)
  end

  def set_comment
    @comment = PostComment.find_by(id: params.dig(:comment, :id))
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :image)
  end
end
