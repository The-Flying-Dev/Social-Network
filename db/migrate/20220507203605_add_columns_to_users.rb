class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false #database constraints
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
  end

  add_index :users, :username, unique: true
  add_index :users, :email, unique: true
end
