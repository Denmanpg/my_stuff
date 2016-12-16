class AddAuthorToBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :blog_posts, :author, foreign_key: true
  end
end
