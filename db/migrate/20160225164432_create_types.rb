class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name, null: false, unique: true

      t.index :name
      
      t.timestamps null: false
    end
  end
end
