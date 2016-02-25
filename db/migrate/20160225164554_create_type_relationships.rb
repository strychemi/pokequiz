class CreateTypeRelationships < ActiveRecord::Migration
  def change
    create_table :type_relationships do |t|
      t.integer :attack_type_id, null: false
      t.integer :defend_type_id, null: false
      t.string :effectiveness, null: false

      t.index [:attack_type_id, :defend_type_id], unique: true

      t.timestamps null: false
    end
  end
end
