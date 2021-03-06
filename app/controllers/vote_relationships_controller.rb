class VoteRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    if @post.approved?
      if params[:like] == '1'
        current_user.like(@post)
        update_vote
      else
        current_user.dislike(@post)
        update_vote
      end
    else
      raise 'Post is not approved'
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @post = VoteRelationship.find(params[:id]).post
    current_user.neutralize(@post)
    update_vote
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = 'Please login first!'
        redirect_to new_user_session_url
      end
    end

    def update_vote
      vote = @post.popularity
      @post.update_attributes(vote: vote)
    end
end
