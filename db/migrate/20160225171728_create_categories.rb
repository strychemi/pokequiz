class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name,  null: false, unique: true

      t.index :name
      t.timestamps null: false
    end
  end
end
