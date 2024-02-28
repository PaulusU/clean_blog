class StaticPagesController < ApplicationController
  
  def index
    if params[:query].present?
      @results = BlogPost.where("title LIKE ?", "%#{params[:query]}%")
    else
      @results = []  # Ensure @results is always assigned, even if there's no query
    end
  end

  def recent_search
   @blog_posts = BlogPost.joins(:user).where("blog_posts.title LIKE :query OR blog_posts.summary LIKE :query OR users.name LIKE :query", query: "%#{params[:q]}%")
  end

  def home
    @blog_posts = BlogPost.limit(5).order(created_at: :desc)
  end

  def about
  end

  def blog
    @blog_posts = BlogPost.paginate(page: params[:page])
  end
end
