require "test_helper"

class BlogPostControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get blog_post_new_url
    assert_response :success
  end
end
