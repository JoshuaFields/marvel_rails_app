class MarvelApi
  attr_reader :character, :data

  def initialize(character)
    @character = character
    @character_name = character.character_name
    @character_id = get_character_id
  end

  def get_series
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters/#{@character_id}/series?titleStartsWith=#{@character.character_name}&orderBy=startYear&limit=5&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["title"]
  end

  def last_three
    "Needs to be implemented"
  end

  def first_three
    "Needs to be implemented"
  end

  def bio
    HTTParty.get("http://gateway.marvel.com:80/v1/public/"\
    "characters?name=#{@character_name}&ts=#{timestamp}&apikey=#{public_key}"\
    "&hash=#{encrypt_request}")["data"]["results"][0]["description"]
  end

  def get_character_id
    HTTParty.get("http://gateway.marvel.com:80/v1/"\
    "public/characters?name=#{@character_name}&ts=#{timestamp}&apikey="\
    "#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["id"]
  end

  def character_image
    HTTParty.get("http://gateway.marvel.com:80/v1/"\
    "public/characters?name=#{@character_name}&ts=#{timestamp}&apikey=#{public_key}&"\
    "hash=#{encrypt_request}")["data"]["results"][0]["thumbnail"]["path"].to_s + ".jpg"
  end

  def private_key
    ENV['MARVEL_PRIVATE_KEY']
  end

  def public_key
    ENV['MARVEL_PUBLIC_KEY']
  end

  def timestamp
    "#{Time.now.to_i}"
  end

  def encrypt_request
    Digest::MD5.hexdigest("#{timestamp}" + "#{private_key}" + "#{public_key}")
  end
end
