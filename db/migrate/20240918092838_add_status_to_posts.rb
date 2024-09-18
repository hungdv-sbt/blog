class AddStatusToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :status, :string, default: 'draft'
    add_column :posts, :image, :string
  end
end
