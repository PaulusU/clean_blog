class BlogPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user,   only: :destroy

  def index
    @blog_posts = BlogPost.all.order(created_at: :desc)
  end

  def upload
    @blog_post = current_user.blog_post.build if logged_in?
  end  

  def show
    @blog_post = BlogPost.find(params[:id])
  end

  def edit
    @blog_post = BlogPost.find(params[:id])
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      flash[:success] = "Blog updated"
      if current_user.admin?
      redirect_to blog_post_path
    else
      redirect_to user_path(@blog_post.user)
    end
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def search
    @blog_posts = BlogPost.paginate(page: params[:page])
    @blog_posts = BlogPost.where("title LIKE :query OR summary LIKE :query", query: "%#{params[:q]}%")
  end
  
  def create
    @blog_post = current_user.blog_post.build(blog_post_params)
    tags = params[:blog_post][:tags].split(",").map(&:strip)
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @blog_post.tags << tag
    end

    @blog_post.image.attach(params[:blog_post][:image])
    if @blog_post.save
      flash[:success] = "Blog Created!"
      redirect_to blog_post_path
    else
      render 'upload', status: :see_other
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    flash[:success] = "Blog deleted"
    if request.referrer.nil?
      redirect_to current_user, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end  
  
  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :summary, :content, :image)
  end

  def correct_user
    @blog_post = BlogPost.find(params[:id])
    unless current_user && (current_user.admin? || current_user == @blog_post.user)
      flash[:danger] = "Unauthorized access!"
      redirect_to root_url
    end
  end  

end
