require "test_helper"

class BlogPostsControllerTest < ActionDispatch::IntegrationTest
  # Set up test data before running the tests
  setup do
    @blog_post = blog_posts(:one) # Use fixture data for testing
    @decorator = BlogPostDecorator.new(@blog_post) # Decorator for word count and reading time
  end

  # Test for fetching the index of blog posts
  test "should get index" do
    # Send a GET request to the index action
    get blog_posts_url, as: :json
    assert_response :success

    # Parse the JSON response and validate the size of the result
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response.size
  end

  # Test for creating a new blog post
  test "should create blog_post" do
    # Check if the blog post count increases by 1
    assert_difference("BlogPost.count") do
      post blog_posts_url, params: { blog_post: { title: "Test Post", content: "Test Content", published: true } }, as: :json
    end

    # Validate the response status is :created (201)
    assert_response :created

    # Parse the JSON response
    json_response = JSON.parse(response.body)

    # Validate the word count and reading time
    assert_equal 2, json_response["word_count"], "Word count should match the content"
    assert_equal "1 minute(s)", json_response["reading_time"]
  end

  # Test for showing a specific blog post
  test "should show blog_post" do
    # Send a GET request to the show action for a specific blog post
    get blog_post_url(@blog_post), as: :json
    assert_response :success

    # Parse the JSON response and validate the title matches the fixture
    json_response = JSON.parse(response.body)
    assert_equal @blog_post.title, json_response["title"]

    # Validate the word count and reading time
    assert_equal @decorator.word_count, json_response["word_count"], "Word count should match the calculated value"
    assert_equal "1 minute(s)", json_response["reading_time"]
  end

  # Test for updating a blog post
  test "should update blog_post" do
    # Send a PATCH request to update the title and content of a specific blog post
    patch blog_post_url(@blog_post), params: { blog_post: { title: "Updated Title", content: "Updated content." } }, as: :json
    assert_response :ok

    # Parse the JSON response and validate the title and content are updated
    json_response = JSON.parse(response.body)
    assert_equal "Updated Title", json_response["title"]
    assert_equal "Updated content.", json_response["content"]

    # Validate the word count and reading time
    updated_decorator = BlogPostDecorator.new(@blog_post.reload)
    assert_equal updated_decorator.word_count, json_response["word_count"], "Word count should match the updated content"
    assert_equal "1 minute(s)", json_response["reading_time"]
  end

  # Test for deleting a blog post
  test "should destroy blog_post" do
    # Check if the blog post count decreases by 1
    assert_difference("BlogPost.count", -1) do
      delete blog_post_url(@blog_post), as: :json
    end

    # Validate the response status is :no_content (204)
    assert_response :no_content
  end
end
