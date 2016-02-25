class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :follower_id,  null: false
      t.integer :followed_id, null: false

      t.index [:follower_id, :followed_id], unique: true
      t.timestamps null: false
    end
  end
end
