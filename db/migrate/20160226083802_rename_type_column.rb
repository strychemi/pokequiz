class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :profiles, :type_id, :pokemon_type_id
  end
end
