class CharacterLoader
  def initialize(character)
    @character = character
  end

  def retrieve_character_bio
    if @character.character_bio.nil?
      unless marvel_api.bio.nil?
        @character.character_bio = marvel_api.bio
        @character.save!
      else
        @character.character_bio = marvel_api.get_alt_bio
        @character.save!
      end
    end
  end

  def retrieve_character_wiki
    if @character.character_wiki_url.nil?
      @character.character_wiki_url = marvel_api.get_wiki
      @character.save!
    end
  end

  def retrieve_character_image
    if @character.character_image_url.nil?
      @character.character_image_url = marvel_api.get_character_image
      @character.save!
    end
  end

  protected
  def marvel_api
    @marvel_api ||= MarvelApi.new(@character)
  end
end
