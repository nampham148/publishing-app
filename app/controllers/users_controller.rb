class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where("approved = ? and to_post < ?", true, Time.current).
                         order(post_date: :desc, vote: :desc).page(params[:page]).per_page(10)
    if current_user == @user 
      @post = current_user.posts.build(to_post: Time.now.strftime('%Y-%m-%dT%H:%M'))
    end
  end

  def index
  end
end
