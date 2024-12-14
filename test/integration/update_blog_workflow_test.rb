require 'test_helper'

class UpdateBlogWorkflowTest < ActionDispatch::IntegrationTest
  # Setup: Create a blog post to be updated in the test
  setup do
    @blog_post = BlogPost.create!(
      title: "Original Title",
      content: "This is original content.",
      published: true
    )
  end

  # Test for updating a blog post and verifying the changes
  test "should update the blog post with new content and reflect changes" do
    # Send a PATCH request to update the specific blog post
    patch "/blog_posts/#{@blog_post.id}",
          params: { blog_post: { title: "Updated Title", content: "Updated content." } },
          as: :json

    # Assert that the response status is :ok (200)
    assert_response :ok

    # Parse the JSON response body
    json_response = JSON.parse(response.body)

    # Assert that the blog post title and content are updated correctly
    assert_equal "Updated Title", json_response["title"]
    assert_equal "Updated content.", json_response["content"]
  end
end