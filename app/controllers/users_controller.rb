class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.approved.posted.standard_order.page(params[:page]).per_page(10)
    if current_user == @user 
      @post = current_user.posts.build(to_post: Time.now.strftime('%Y-%m-%dT%H:%M'))
    end
  end

  def index
  end
end
