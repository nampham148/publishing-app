class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:update, :edit, :destroy]
  before_action :admin, only: [:pending, :approve]

  def index
    @posts = Post.approved.posted.standard_order.page(params[:page]).per_page(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:info] = 'Your post is waiting to be reviewed by admins'
    else
      flash[:danger] = "Can't post!"
    end
    redirect_to current_user
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Successfully deleted'
    #PROBABLY SHOULD CHANGE THIS
    redirect_to root_url
  end

  def pending
    @posts = Post.unapproved.pending_order.page(params[:page]).per_page(10)
  end

  def approve
    @post = Post.find(params[:id])
    if @post.approved?
      flash[:info] = 'Post has already been approved'
      redirect_to root_url
    else
      #update approved states and posted_at time
      @post.update_attributes(approved: true, approved_at: Time.zone.now)
      posted_at = @post.to_post < @post.approved_at ? @post.approved_at : @post.to_post
      @post.update_attributes(posted_at: posted_at, post_date: posted_at.to_date)
      
      flash[:success] = 'Approved Post!'
      redirect_to root_url
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def logged_in_user
      unless user_signed_in?
        flash[:danger] = 'Please login first!'
        redirect_to new_user_session_url
      end
    end

    def correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user || current_user.admin?
        flash[:danger] = 'Access not allowed'
        redirect_to root_url
      end
    end

    def admin
      unless current_user.admin?
        flash[:danger] = "You don't have access to this page"
        redirect_to root_url 
      end
    end
end
