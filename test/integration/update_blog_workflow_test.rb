require "test_helper"

class UpdateBlogWorkflowTest < ActionDispatch::IntegrationTest
  setup do
    @blog_post = BlogPost.create!(
      title: "Original Title",
      content: "This is original content.",
      published: true
    )
  end

  test "should update the blog post and verify changes" do
    patch "/blog_posts/#{@blog_post.id}",
          params: { blog_post: { title: "Updated Title", content: "Updated content with more words." } },
          as: :json

    assert_response :ok
    json_response = JSON.parse(response.body)

    assert_equal "Updated Title", json_response["title"]
    assert_equal "Updated content with more words.", json_response["content"]

    # Validate updated word count and reading time
    assert_equal 5, json_response["word_count"] # Update based on word count logic
    assert_equal "1 minute(s)", json_response["reading_time"] # Update if method changes
  end
end
