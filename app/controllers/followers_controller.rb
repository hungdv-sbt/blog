class FollowersController < ApplicationController
  def follower
    follower = current_user.followers.save(params[:follower_id])
    return render json: {}, status: :bad_request unless follower.save

    render json: {}, status: :ok
  end

  def unfollower
    follower = current_user.followers.find_by(id: params[:follower_id])
    return render json: {}, status: :not_found unless follower

    follower.destroy
    render json: {}, status: :ok
  end
end
