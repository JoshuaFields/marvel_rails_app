class AddMarvelIdToCharacters < ActiveRecord::Migration
  def up
    add_column :characters, :marvel_id, :string
  end

  def down
    remove_column :characters, :marvel_id
  end
end
