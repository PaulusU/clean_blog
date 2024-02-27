class BlogPostController < ApplicationController
  before_action :logged_in_user, only: [:create, :destory]

  def upload
    @blog_post = current_user.blog_post.build if logged_in?
  end  
  
  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    if @blog_post.save
      flash[:success] = "Blog Created!"
      redirect_to blog_post_path
    else
      flash.now[:danger] = "Error"
      redirect_to upload_blog_path, status: :see_other
    end
  end
  
  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :summary, :content)
  end
  
end
