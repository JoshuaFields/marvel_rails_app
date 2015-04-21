desc "Load Characters from Marvel API"
task :load_characters => :environment do
  Character.find_each do |character|
    CharacterLoader.new(character).retrieve_character_image
    CharacterLoader.new(character).retrieve_character_bio
    CharacterLoader.new(character).retrieve_character_wiki
  end
end
