class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@posts = @user.posts.where(approved: true)
  end

  def index
  end
end
