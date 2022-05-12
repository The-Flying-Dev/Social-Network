class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|      
      t.integer :friend_id
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
