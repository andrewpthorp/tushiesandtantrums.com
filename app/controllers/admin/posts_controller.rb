class Admin::PostsController < Admin::BaseController

  # GET /admin/posts
  def index
    @published = Post.published.page(params[:published_page])
    @drafted = Post.drafted.page(params[:draft_page])
  end

  # GET /admin/posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end

  # PUT /admin/posts/:id
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to admin_posts_path, notice: "Post successfully updated!"
    else
      flash[:error] = "There was a problem updating that post. Please make sure you filled out all of the fields"
      render :edit
    end
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # POST /admin/posts
  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to admin_posts_path, notice: "Post successfully created!"
    else
      flash[:error] = "There was a problem creating that post. Please make sure you filled out all of the fields"
      render :new
    end
  end

  # DELETE /admin/posts/:id
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
