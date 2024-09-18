# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def publishable?
    user.admin?
  end
end
