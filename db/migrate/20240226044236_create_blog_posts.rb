class CreateBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_posts do |t|
      t.string :title, limit: 50
      t.string :summary, limit: 150
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.string :title_image_url

      t.timestamps
    end
    add_index :blog_posts, [:user_id, :created_at]
  end
end
