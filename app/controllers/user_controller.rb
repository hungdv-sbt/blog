class UsersController < ApplicationController
  def follower_users
    @follower_users = User.where(id: current_user.followers.pluck(:follower_id))
  end
end
