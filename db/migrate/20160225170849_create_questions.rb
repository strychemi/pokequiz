class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question, null: false, unique: true
      t.string :solution, null: false
      t.string :option_1, null: false
      t.string :option_2, null: false
      t.string :option_3, null: false

      t.integer :category_id, null: false
      t.integer :frequency, null: false

      t.index [:question, :category_id]
      t.timestamps null: false
    end
  end
end
