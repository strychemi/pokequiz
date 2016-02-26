class CreatePokemonTypes < ActiveRecord::Migration
  def change
    create_table :pokemon_types do |t|
      t.string :name, null: false, unique: true

      t.index :name
      
      t.timestamps null: false
    end
  end
end
