class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name, null: false
      t.integer :first_type_id, null: false
      t.integer :second_type_id

      t.index :name, unique: true

      t.timestamps null: false
    end
  end
end
