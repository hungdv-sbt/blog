class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.bigint 'user_id'
      t.text 'description'
      t.datetime "deleted_at"
      t.timestamps
    end
  end
end
