class StaticPagesController < ApplicationController
  def home
    @blog_posts = BlogPost.paginate(page: params[:page])
  end

  def about
  end

  def blog_post
  end
end
