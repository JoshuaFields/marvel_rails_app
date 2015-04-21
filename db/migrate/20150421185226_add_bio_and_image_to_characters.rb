class AddBioAndImageToCharacters < ActiveRecord::Migration
  def up
    add_column :characters, :character_image_url, :string
  end

  def down
    remove_column :characters, :character_image_url
  end
end
