class RemoveAuthorFromBlogPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :blog_posts, :author_id, :integer
  end
end
