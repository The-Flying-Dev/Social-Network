class Posts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :title, :string
    remove_column :posts, :url, :string
    remove_column :posts, :type, :string
  end
end
