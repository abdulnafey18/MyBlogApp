require "application_system_test_case"

class BlogPostsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  setup do
    @blog_post = BlogPost.create!(
      title: "Test Blog",
      content: "This is a sample blog post content.",
      published: true
    )
  end

  test "visiting the blog posts index" do
    visit "/"
    assert_selector "h1", text: "Blog Posts"
  end

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

    # Validate word count and reading time
    assert_text "Word Count: 9" # Update based on the content
    assert_text "Reading Time: 1 minute(s)"
  end

  test "updating an existing blog post" do
    visit "/"
    click_on "Show", match: :first
    click_on "Edit"

    fill_in "Title", with: "Updated Blog Post"
    fill_in "Content", with: "Updated content for this blog post with more and more words."
    uncheck "Published"
    click_on "Save Changes"

    assert_text "Updated Blog Post"
    assert_text "Updated content for this blog post with more and more words."
    assert_text "Published: No"

    # Validate updated word count and reading time
    assert_text "Word Count: 11" # Update based on the updated content
    assert_text "Reading Time: 1 minute(s)"
  end

  test "destroying a blog post" do
    visit "/"
    click_on "Show", match: :first
    click_on "Destroy"

    refute_text @blog_post.title
  end
end
