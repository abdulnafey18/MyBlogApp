class BlogPostsController < ApplicationController
  # Set the blog post for actions requiring a specific record
  before_action :set_blog_post, only: %i[show update destroy]

  # GET /blog_posts.json
  # Retrieves all blog posts and renders them in JSON format
  def index
    @blog_posts = BlogPost.all
    # Decorate each blog post before serialization
    decorated_posts = @blog_posts.map { |post| BlogPostDecorator.new(post) }
    # Render the serialized JSON data
    render json: decorated_posts.map { |post| serialized_post(post) }
  end

  # GET /blog_posts/1.json
  # Retrieves a specific blog post and renders it in JSON format
  def show
    decorated_post = BlogPostDecorator.new(@blog_post)
    render json: serialized_post(decorated_post)
  end

  # POST /blog_posts.json
  # Creates a new blog post and returns the created record in JSON format
  def create
    # Log incoming parameters for debugging purposes
    Rails.logger.debug("Blog Post Params: #{blog_post_params.inspect}")
    @blog_post = BlogPost.new(blog_post_params)

    # Save the blog post and respond with the serialized record or an error
    if @blog_post.save
      decorated_post = BlogPostDecorator.new(@blog_post)
      Rails.logger.debug("Serialized Created Post: #{serialized_post(decorated_post)}")
      render json: serialized_post(decorated_post), status: :created
    else
      Rails.logger.error("Failed to Create Blog Post: #{@blog_post.errors.full_messages}")
      render json: @blog_post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blog_posts/1.json
  # Updates an existing blog post and returns the updated record in JSON format
  def update
    if @blog_post.update(blog_post_params)
      decorated_post = BlogPostDecorator.new(@blog_post)
      render json: serialized_post(decorated_post), status: :ok
    else
      render json: @blog_post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blog_posts/1.json
  # Deletes an existing blog post and returns no content
  def destroy
    @blog_post.destroy!
    head :no_content
  end

  private

  # Serializes a decorated blog post into a JSON-ready hash
  def serialized_post(decorated_post)
    Rails.logger.debug("Decorated Post: #{decorated_post.inspect}")
    {
      id: decorated_post.instance_variable_get(:@blog_post).id,
      title: decorated_post.instance_variable_get(:@blog_post).title,
      content: decorated_post.instance_variable_get(:@blog_post).content,
      published: decorated_post.instance_variable_get(:@blog_post).published,
      category: decorated_post.assigned_category,
      summary: decorated_post.summary,
      word_count: decorated_post.word_count,
      reading_time: "#{decorated_post.reading_time} minute(s)",
      created_at: decorated_post.instance_variable_get(:@blog_post).created_at&.iso8601,
      updated_at: decorated_post.instance_variable_get(:@blog_post).updated_at&.iso8601
    }
  end

  # Finds a blog post by ID for actions requiring a specific record
  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  # Permits only specific parameters for blog post creation and updates
  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published)
  end
end