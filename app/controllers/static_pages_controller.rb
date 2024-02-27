class StaticPagesController < ApplicationController
  def home
    @blog_posts = BlogPost.limit(5).order(created_at: :desc)
  end

  def about
  end

  def blog
    @blog_posts = BlogPost.paginate(page: params[:page])
  end
end
