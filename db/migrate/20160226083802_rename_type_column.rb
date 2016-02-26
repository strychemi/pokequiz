class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :pokemon_types, :type_id, :pokemon_type_id
  end
end
