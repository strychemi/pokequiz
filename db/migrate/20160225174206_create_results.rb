class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false
      t.boolean :result, null: false

      t.index [:user_id, :question_id]
      t.timestamps null: false
    end
  end
end
