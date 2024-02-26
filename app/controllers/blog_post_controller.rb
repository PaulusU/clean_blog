class BlogPostController < ApplicationController
  def new
    @blog_posts = BlogPost.paginate(page: params[:page])
  end
end
