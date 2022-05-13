class RemoveTypePosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :type, :string
  end
end
