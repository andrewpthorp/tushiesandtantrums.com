class PostsController < ApplicationController
  before_filter :set_active_navigation

  # GET /posts
  def index
    @latest = Post.latest
    @posts = Post.published.ordered.exclude(@latest.id).page(params[:page])
  end

  # GET /posts/:id
  def show
    @post = Post.find(params[:id])
  end

private

  def set_active_navigation
    @active_navigation = 'posts'
  end

end
