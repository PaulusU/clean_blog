class ApplicationController < ActionController::Base
  include SessionsHelper 

    private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    def current_user?(user)
      user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
