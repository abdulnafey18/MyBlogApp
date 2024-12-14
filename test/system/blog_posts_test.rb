require "application_system_test_case"

class BlogPostsTest < ApplicationSystemTestCase
  setup do
    @blog_post = BlogPost.create!(
      title: "My First Blog Post",
      content: "This is the content of my first blog post.",
      category: "Technology",
      published: true,
      created_at: Time.now - 1.day,
      updated_at: Time.now - 1.day
    )
    puts "Created blog post with ID: #{@blog_post.id}" # Debug output
    Capybara.app_host = "http://localhost:3000"
  end

  # Test visiting the index
  test "visiting the index" do
    visit "/" # Navigate to the blog posts index
    assert_selector "h1", text: "Blog Posts" # Match the header text
  end

  # Test creating a blog post
  test "should create blog post" do
    visit "/"
    click_on "New Blog Post"
  
    fill_in "title", with: "Test Blog Post"
    fill_in "content", with: "This is a test blog post content."
    check "Published"
    click_on "Save"
  
    # Navigate back to the blog list
    visit "/"
  
    # Assertions for the created post
    assert_text "Test Blog Post"
    assert_text "This is a test blog post content."
    assert_text "Published: Yes"
  end

  # Test updating a blog post
  test "should update blog post" do
    visit "/" # Navigate to the blog posts index
    click_on "Show", match: :first # Open the show page for the first blog post
    click_on "Edit" # Navigate to the edit page

    fill_in "title", with: "Updated Blog Post Title"
    fill_in "content", with: "Updated content for the blog post."
    uncheck "Published" # Toggle the published checkbox
    click_on "Save Changes" # Submit the form

    # Assertions for the updated blog post
    visit "/" # Back to index
    assert_text "Updated Blog Post Title"
    assert_text "Updated content for the blog post."
    assert_text "Published: No"
  end

  # Test destroying a blog post
  test "should destroy blog post" do
    visit "/" # Navigate to the blog posts index
    click_on "Show", match: :first # Open the show page for the first blog post
    click_on "Destroy" # Trigger the delete action

    # Assertions for deletion
    assert_no_text @blog_post.title # Ensure the blog post is no longer listed
  end

end