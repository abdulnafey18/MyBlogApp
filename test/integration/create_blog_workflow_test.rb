require "test_helper"

class CreateBlogWorkflowTest < ActionDispatch::IntegrationTest
  test "should create a new blog post and verify its attributes" do
    post "/blog_posts", params: { blog_post: { title: "New Blog Post", content: "This is a test blog post content.", published: true } }, as: :json

    assert_response :created
    json_response = JSON.parse(response.body)

    assert_equal "New Blog Post", json_response["title"]
    assert_equal "This is a test blog post content.", json_response["content"]
    assert_equal true, json_response["published"]

    # Validate word count and reading time
    assert_equal 7, json_response["word_count"] # Update based on word count logic
    assert_equal "1 minute(s)", json_response["reading_time"] # Update if method changes
  end
end
