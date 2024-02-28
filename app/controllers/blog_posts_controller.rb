class BlogPostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @blog_posts = BlogPost.all.order(created_at: :desc)
  end

  def upload
    @blog_post = current_user.blog_post.build if logged_in?
  end  

  def search
    @blog_posts = BlogPost.paginate(page: params[:page])
    @blog_posts = BlogPost.where("title LIKE :query OR summary LIKE :query", query: "%#{params[:q]}%")
  end
  
  def create
    @blog_post = current_user.blog_post.build(blog_post_params)
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
    params.require(:blog_post).permit(:title, :summary, :content)
  end

  def correct_user
    @blog_post = current_user.blog_post.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @blog_post.nil?
  end

end
