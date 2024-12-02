class CreatePostComments < ActiveRecord::Migration[6.0]
  def change
    create_table :post_comments do |t|
      t.bigint :user_comment_id
      t.text :comment
      t.bigint :post_id
      t.timestamps
    end
  end
end
