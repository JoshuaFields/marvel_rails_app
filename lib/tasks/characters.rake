desc "Load Characters from Marvel API"
task :load_characters => :environment do
  Character.find_each do |character|
    CharacterLoader.new(character).retrieve_character_wiki
    CharacterLoader.new(character).retrieve_character_bio
    CharacterLoader.new(character).retrieve_marvel_character_id
    CharacterLoader.new(character).retrieve_identity
    CharacterLoader.new(character).retrieve_group
    CharacterLoader.new(character).retrieve_powers
    CharacterLoader.new(character).retrieve_abilities
    CharacterLoader.new(character).retrieve_first_issue
    CharacterLoader.new(character).retrieve_character_image
  end
end
