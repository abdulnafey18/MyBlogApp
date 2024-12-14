require 'test_helper'

class CreateBlogWorkflowTest < ActionDispatch::IntegrationTest
  # Test for creating a new blog post and verifying its attributes
  test "should try to create a new blog post with additional functionality" do
    # Send a POST request to the create action with JSON payload
    post "/blog_posts", params: { blog_post: { title: "New Blog Post", content: "This is a test blog post content.", published: true } }, as: :json
    
    # Validate the response status is :created (201)
    assert_response :created

    # Parse the JSON response
    json_response = JSON.parse(response.body)

    # Assertions to validate the created blog post's attributes
    assert_equal "New Blog Post", json_response["title"] # Title matches the input
    assert_equal "This is a test blog post content.", json_response["content"] # Content matches the input
    assert_equal true, json_response["published"] # Published status matches the input

    # Validate the auto-assigned category based on content
    assert_equal "Technology", json_response["category"] # Update this if auto-assignment changes
  end
end