class CreateFollowings < ActiveRecord::Migration[8.0]
  def change
    create_table :followings do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps
    end

    add_index :followings, [ :follower_id, :followee_id ], unique: true
  end
end
