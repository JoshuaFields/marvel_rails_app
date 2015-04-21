require 'open-uri'

class MarvelApi
  attr_reader :character, :data

  def initialize(character)
    @character = character
    @character_name = character.character_name
    @character_id = get_character_id
  end

  def get_series
    count = 0
    series_array = []
    until count == 3
      series = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters/#{@character_id}/series?titleStartsWith=#{@character.character_name}&orderBy=startYear&limit=3&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][count]
      series_array << series
      count += 1
    end
    series_array
  end

  def get_newest
    count = 0
    series_array = []
    until count == 2
      series = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters/#{@character_id}/series?titleStartsWith=#{@character.character_name}&orderBy=-startYear&limit=2&apikey=#{public_key}&ts=#{timestamp}&hash=#{encrypt_request}")["data"]["results"][count]
      series_array << series
      count += 1
    end
    series_array
  end

  def self.box_xl(series)
    unless series == nil
      series["thumbnail"]["path"] + "/standard_xlarge.jpg"
    else
      "not found"
    end
  end

  def self.box_fantastic(series)
    series["thumbnail"]["path"] + "/standard_fantastic.jpg"
  end

  def self.portrait(series)
    unless series == nil
      series["thumbnail"]["path"] + "/portrait_uncanny.jpg"
    else
      "not found"
    end
  end

  def self.landscape(series)
    unless series == nil
      series["thumbnail"]["path"] + "/landscape_incredible.jpg"
    else
      "not found"
    end
  end

  def self.title(series)
    unless series == nil
      series["title"]
    else
      "No comic is available"
    end
  end

  def self.get_url(series)
    unless series == nil
      series["urls"][0]["url"]
    else
      "#"
    end
  end

  def self.get_comic_id(series)
    comic_id = series["comics"]["items"][0]["resourceURI"]
    comic_id = comic_id.delete("http://gateway.marvel.com/v1/public/comics/")
    comic_id
  end

  def self.get_series_id(series)
    series["id"]
  end

  def alt_image(comic_id)
    data = HTTParty.get("http://gateway.marvel.com:80/v1/public/comics/#{comic_id}?apikey=#{public_key}&ts=#{timestamp}&hash=#{encrypt_request}")

    if data["code"] == 200
      data["data"]["results"][0]["thumbnail"]["path"]
    else
      character_image.gsub(".jpg", "")
    end
  end

  def alt_series_image(series_id)
    data = HTTParty.get("http://gateway.marvel.com:80/v1/public/series/#{series_id}/comics?apikey=#{public_key}&ts=#{timestamp}&hash=#{encrypt_request}")

    if data["code"] == 200
      data["data"]["results"][0]["thumbnail"]["path"]
    else
      character_image.gsub(".jpg", "")
    end
  end

  def bio
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["description"]
  end

  def get_character_id
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["id"]
  end

  def character_image
    name_case = @character_name
    result = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{name_case}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["thumbnail"]

    if result == nil
      name_case = @character_name.downcase
      result = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{name_case}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["thumbnail"]
    else
      result["path"] + ".jpg"
    end
    result["path"] + ".jpg"
  end

  def get_wiki
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]
  end

  ## Nokogiri Methods ##

  def get_alt_bio
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))

    wiki.at_css('#biobody').content
  end

  def get_identity
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))

    identity = wiki.css('#powerbox p')[1]
    if identity.nil?
      "Not available"
    else
      identity.content.sub("Real Name", "")
    end
  end

  def get_first_issue
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))

    issue = wiki.css('#powerbox p')[6]
    if issue.nil?
      "Not available"
    else
      issue.content.sub("First Appearance", "")
    end
  end

  def get_powers
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))

    powers = wiki.at_css('#char-powers')
    if powers.nil?
      "Not available"
    else
      powers.content.sub("Powers", "")
    end
  end

  def get_abilities
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))
      abilities = wiki.at_css('#char-abilities')
      if abilities.nil?
        "Not available"
      else
        abilities.content.sub("Abilities", "")
      end
  end

  def get_group
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))
      abilities = wiki.at_css('#char-affiliation')
      if abilities.nil?
        "Not available"
      else
        abilities.content.sub("Group Affiliation", "")
      end
  end

  #possibly take out. not working for everyone
  def get_headshot_image
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))

    pic = wiki.css('#headshot img').to_s
    pic.sub("thumb/", "")
  end

  private

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
