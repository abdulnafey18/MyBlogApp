require 'test_helper'
require 'blog_post_decorator'

class BlogPostDecoratorTest < ActiveSupport::TestCase
  # Setup: Create a test blog post and initialize the decorator
  setup do
    @blog_post = BlogPost.create!(
      title: "My First Blog Post",
      content: "This is the content of my first blog post.",
      published: true,
      category: "Technology",
      created_at: Time.now - 1.day,
      updated_at: Time.now - 1.hour
    )
    @decorator = BlogPostDecorator.new(@blog_post)
  end

  # Test the word_count method to ensure correct word count
  test "word_count returns the correct number of words" do
    # Assert that the word count matches the expected value
    assert_equal 9, @decorator.word_count
  end

  # Test the reading_time method to ensure correct calculation
  test "reading_time calculates correctly" do
    # Assert that the reading time matches the expected value
    assert_equal 1, @decorator.reading_time
  end

  # Test the formatted_created_at method to ensure proper date formatting
  test "formatted_created_at returns correct format" do
    # Expected format for the created_at timestamp
    expected_format = @blog_post.created_at.strftime("%B %d, %Y at %I:%M %p")
    # Assert that the formatted date matches the expected value
    assert_equal expected_format, @decorator.formatted_created_at
  end

  # Test the formatted_updated_at method to ensure proper date formatting
  test "formatted_updated_at returns correct format" do
    # Expected format for the updated_at timestamp
    expected_format = @blog_post.updated_at.strftime("%B %d, %Y at %I:%M %p")
    # Assert that the formatted date matches the expected value
    assert_equal expected_format, @decorator.formatted_updated_at
  end

  # Validate the decorated_content method output
  test "decorated_content returns correctly formatted string" do
    # Expected formatted content as a string
    expected_content = <<~CONTENT
      Title: My First Blog Post
      Summary: This is the content of my first blog post.
      Category: Technology
      Word Count: 9
      Reading Time: 1 minute(s)
      Published on: #{@decorator.formatted_created_at}
      Last updated: #{@decorator.formatted_updated_at}
    CONTENT
    # Assert that the decorated content matches the expected value
    assert_equal expected_content.strip, @decorator.decorated_content.strip
  end
end