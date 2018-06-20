class PostsController < ApplicationController
  before_action :logged_in_user
  #to be updated later to allow admins
  before_action :correct_user, only: [:update, :edit, :destroy]
  before_action :admin, only: [:pending, :approve]

  def index
    @posts = Post.where(approved: true)
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Successfully posted!"
    else
      flash[:danger] = "Can't save!"
    end
    redirect_to current_user
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def pending
    @posts = Post.where(approved:false)
  end

  def approve
    @post = Post.find(params[:id])
    if @post.approved?
      flash[:info] = "Post has already been approved"
      redirect_to root_url
    else
      @post.update_attributes(approved: true)
      flash[:success] = "Approved Post!"
      redirect_to root_url
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :to_post)
    end

    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "Please login first!"
        redirect_to new_user_session_url
      end
    end

    def correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user || current_user.admin?
        flash[:danger] = "Access not allowed"
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
