require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
  setup do
    # Using fixtures for all test cases
    @fixture_post_one = blog_posts(:one)
    @fixture_post_two = blog_posts(:two)
  end

  # Test saving a blog post (new record, if needed)
  test "should save blog post" do
    assert_difference('BlogPost.count', 1) do
      BlogPost.create(
        title: "Fixture Test Blog",
        content: "This is a blog post created to test saving functionality.",
        published: true,
        category: "Education"
      )
    end
  end

  # Test finding a blog post
  test "should find blog post" do
    found_post = BlogPost.find(@fixture_post_one.id)
    assert_equal found_post.title, @fixture_post_one.title
    assert_equal found_post.content, @fixture_post_one.content
    assert_equal found_post.published, @fixture_post_one.published
    assert_equal found_post.category, @fixture_post_one.category
  end

  # Test deleting a blog post
  test "should delete blog post" do
    assert_difference('BlogPost.count', -1) do
      @fixture_post_one.destroy
    end
  end

  # Test updating a blog post
  test "should update blog post title and category" do
    @fixture_post_one.update(title: "Updated Title", category: "Business")
    assert_equal "Updated Title", @fixture_post_one.title
    assert_equal "Business", @fixture_post_one.category
  end

  # Test published status
  test "should be published when true" do
    assert @fixture_post_one.published, "Expected blog post to be published"
  end

  test "should be unpublished when false" do
    @fixture_post_two.update(published: false)
    assert_not @fixture_post_two.published, "Expected blog post to be unpublished"
  end
end