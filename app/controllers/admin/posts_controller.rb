class Admin::PostsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class PostParams

    # Internal: Build params for creating/updating an Post.
    #
    # Examples
    #
    #   PostParams.build(post: { name: 'Andrew' })
    #   # => { 'name' => 'Andrew' }
    def self.build(params)
      params.require(:post).permit!
    end
  end

  def index
    @published = Post.published.page(params[:published_page])
    @drafted = Post.drafted.page(params[:draft_page])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(PostParams.build(params))
      redirect_to admin_posts_path, notice: "Post successfully updated!"
    else
      flash[:error] = "There was a problem updating that post. Please make sure you filled out all of the fields"
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(PostParams.build(params))

    if @post.save
      redirect_to admin_posts_path, notice: "Post successfully created!"
    else
      flash[:error] = "There was a problem creating that post. Please make sure you filled out all of the fields"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to admin_posts_path, notice: "Post successfully deleted!"
    else
      flash[:error] = "There was a problem deleting that Post. Please try again."
      redirect_to admin_posts_path
    end
  end
end
