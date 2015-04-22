class AddScraperInfoToCharacters < ActiveRecord::Migration
  def up
    add_column :characters, :identity, :string
    add_column :characters, :group, :string
    add_column :characters, :powers, :text
    add_column :characters, :abilities, :text
    add_column :characters, :first_issue, :text
  end

  def down
    remove_column :characters, :identity, :string
    remove_column :characters, :group, :string
    remove_column :characters, :powers, :text
    remove_column :characters, :abilities, :text
    remove_column :characters, :first_issue, :text
  end
end
