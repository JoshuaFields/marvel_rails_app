class AddWikiUrlToCharacters < ActiveRecord::Migration
  def up
    add_column :characters, :character_wiki_url, :string
  end

  def down
    remove_column :characters, :character_wiki_url
  end
end
