class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.bigint 'user_id'
      t.string 'title'
      t.text 'description'
      t.bigint 'status'
      t.string 'file_name'
      t.datetime 'deleted_at'
      t.timestamps
      t.index ['status'], name: 'index_posts_on_status'
    end
  end
end
