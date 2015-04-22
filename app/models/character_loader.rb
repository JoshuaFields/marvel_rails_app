class CharacterLoader
  def initialize(character)
    @character = character
  end

  def retrieve_character_bio
    if @character.character_bio.nil? || @character.character_bio == ""
        @character.character_bio = marvel_api.bio
        @character.save!
    end
  end

  def retrieve_character_wiki
    if @character.character_wiki_url.nil?
      @character.character_wiki_url = marvel_api.get_wiki
      @character.save!
    end
  end

  def retrieve_character_image
    if @character.character_image_url.nil? || @character.character_image_url == "image_not_found.jpg"
      @character.character_image_url = marvel_api.get_character_image
      @character.save!
    end
  end

  def retrieve_marvel_character_id
    if @character.marvel_id.nil?
      @character.marvel_id = marvel_api.get_character_id
      @character.save!
    end
  end

  def retrieve_identity
    if @character.identity.nil?
      @character.identity = marvel_api.get_identity
      @character.save!
    end
  end

  def retrieve_group
    if @character.group.nil?
      @character.group = marvel_api.get_group
      @character.save!
    end
  end

  def retrieve_powers
    if @character.powers.nil?
      @character.powers = marvel_api.get_powers
      @character.save!
    end
  end

  def retrieve_abilities
    if @character.abilities.nil?
      @character.abilities = marvel_api.get_abilities
      @character.save!
    end
  end

  def retrieve_first_issue
    if @character.first_issue.nil?
      @character.first_issue = marvel_api.get_first_issue
      @character.save!
    end
  end

  protected
  def marvel_api
    @marvel_api ||= MarvelApi.new(@character)
  end
end
