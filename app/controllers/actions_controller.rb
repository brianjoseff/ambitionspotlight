class ActionsController < ApplicationController
  def show
    @users = User.all

    @action = Action.find(params[:id])

    @post = current_user.posts.new
    @posts = Post.order('created_at DESC')
  end
end