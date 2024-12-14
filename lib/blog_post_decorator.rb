require 'words_counted'

class BlogPostDecorator
  # Define category keywords for auto classification
  CATEGORY_KEYWORDS = {
    "Technology" => %w[tech software hardware programming AI],
    "Travel" => %w[travel vacation holiday adventure trip],
    "Food" => %w[food recipe cuisine dish meal],
    "Health" => %w[health fitness exercise wellness],
    "Business" => %w[business market economy finance investment]
  }

  # Initialize the decorator with a blog post
  def initialize(blog_post)
    @blog_post = blog_post
  end

  # Calculate the number of words in the content
  def word_count
    # Remove non-alphabetic characters and count words
    clean_content = @blog_post.content.gsub(/[^a-zA-Z\s]/, '').strip
    clean_content.split(/\s+/).size
  end

  # Calculate the estimated reading time (assuming 200 words/minute)
  def reading_time
    (word_count / 200.0).ceil
  end

  # Generate a summary by taking the first 2-3 sentences
  def summary
    sentences = @blog_post.content.split('. ')
    # Add ellipsis if there are more than 2 sentences
    sentences[0..1].join('. ') + (sentences.size > 2 ? '...' : '')
  end

  # Automatically assign a category based on content keywords
  def assigned_category
    category_scores = Hash.new(0)

    # Calculate scores for each category
    CATEGORY_KEYWORDS.each do |category, keywords|
      keywords.each do |keyword|
        # Match keywords as whole words (case-insensitive)
        matches = @blog_post.content.downcase.scan(/\b#{Regexp.escape(keyword.downcase)}\b/)
        category_scores[category] += matches.size
      end
    end

    # Return the category with the highest score, or "Uncategorized" if no matches
    category_scores.max_by { |_, count| count }&.first || "Uncategorized"
  end

  # Format the `created_at` timestamp
  def formatted_created_at
    @blog_post.created_at.strftime("%B %d, %Y at %I:%M %p")
  end

  # Format the `updated_at` timestamp
  def formatted_updated_at
    @blog_post.updated_at.strftime("%B %d, %Y at %I:%M %p")
  end

  # Combine all decorated attributes into a readable string
  def decorated_content
    <<~CONTENT
    Title: #{@blog_post.title}
    Summary: #{summary}
    Category: #{assigned_category}
    Word Count: #{word_count}
    Reading Time: #{reading_time} minute(s)
    Published on: #{formatted_created_at}
    Last updated: #{formatted_updated_at}
    CONTENT
  end
end