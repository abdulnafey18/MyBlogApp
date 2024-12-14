require 'test_helper'

class DeleteBlogWorkflowTest < ActionDispatch::IntegrationTest
  # Setup: Create a blog post to be deleted in the test
  setup do
    @blog_post = BlogPost.create!(
      title: "Delete Me",
      content: "This blog post will be deleted.",
      published: true
    )
  end

  # Test for deleting a blog post and verifying its removal from the database
  test "should delete the blog post and verify its removal" do
    # Send a DELETE request to remove the specific blog post
    delete "/blog_posts/#{@blog_post.id}", as: :json
    
    # Assert that the response status is :no_content (204)
    assert_response :no_content

    # Ensure the deleted blog post no longer exists in the database
    assert_raises(ActiveRecord::RecordNotFound) do
      BlogPost.find(@blog_post.id)
    end
  end
end