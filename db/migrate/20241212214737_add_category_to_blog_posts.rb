class AddCategoryToBlogPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :blog_posts, :category, :string
  end
end
