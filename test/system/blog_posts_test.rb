require "application_system_test_case"

class BlogPostsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  # Setup: Create a sample blog post for tests
  setup do
    @blog_post = BlogPost.create!(
      title: "Test Blog",
      content: "This is a sample blog post content.",
      published: true
    )
  end

  # Test visiting the blog posts index page
  test "visiting the blog posts index" do
    visit "/"
    assert_selector "h1", text: "Blog Posts"
  end

  # Test creating a new blog post
  test "creating a new blog post" do
    visit "/"
    click_on "New Blog Post"

    fill_in "Title", with: "New Blog Post Title"
    fill_in "Content", with: "This is the content of the new blog post."
    check "Published"
    click_on "Save"

    assert_text "New Blog Post Title"
    assert_text "This is the content of the new blog post."
    assert_text "Published: Yes"
  end

  # Test updating an existing blog post
  test "updating an existing blog post" do
    visit "/"
    click_on "Show", match: :first
    click_on "Edit"

    fill_in "Title", with: "Updated Blog Post"
    fill_in "Content", with: "Updated content for this blog post."
    uncheck "Published"
    click_on "Save Changes"

    assert_text "Updated Blog Post"
    assert_text "Updated content for this blog post."
    assert_text "Published: No"
  end

  # Test destroying a blog post
  test "destroying a blog post" do
    visit "/"
    click_on "Show", match: :first
    click_on "Destroy"

    refute_text @blog_post.title
  end
end
