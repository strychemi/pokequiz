class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false
      t.integer :avatar_id
      t.integer :pokemon_id
      t.integer :type_id

      t.index [:first_name, :last_name]
      t.index :username, unique: true

      t.timestamps null: false
    end
  end
end
