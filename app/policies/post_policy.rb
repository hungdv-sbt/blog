class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def show?
    owner_post?
  end

  def edit?
    owner_post?
  end

  def update?
    owner_post?
  end

  private
  def owner_post?
    user.id == post.user_id
  end
end
