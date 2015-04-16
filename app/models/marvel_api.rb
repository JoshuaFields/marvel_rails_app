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
      series = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters/#{@character_id}/series?titleStartsWith=#{@character.character_name}&orderBy=startYear&limit=5&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][count]
      series_array << series
      count += 1
    end
    series_array
  end

  def self.box(series)
    series["thumbnail"]["path"] + "/standard_fantastic.jpg"
  end

  def self.portrait(series)
    series["thumbnail"]["path"] + "/portrait_uncanny.jpg"
  end

  def self.title(series)
    series["title"]
  end

  def self.get_url(series)
    series["urls"][0]["url"]
  end

  def self.get_comic_id(series)
    comic_id = series["comics"]["items"][0]["resourceURI"]
    comic_id = comic_id.delete("http://gateway.marvel.com/v1/public/comics/")
    comic_id
  end

  def alt_image(comic_id)
    data = HTTParty.get("http://gateway.marvel.com:80/v1/public/comics/#{comic_id}?apikey=#{public_key}&ts=#{timestamp}&hash=#{encrypt_request}")

    if data["code"] == 200
      data["data"]["results"][0]["thumbnail"]["path"]
    else
      "not found"
    end
  end

  def bio
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["description"]
  end

  def get_character_id
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["id"]
  end

  def character_image
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["thumbnail"]["path"].to_s + ".jpg"
  end

  def get_wiki
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]
  end

  def get_alt_bio
    wiki = Nokogiri::HTML(open(HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["urls"][1]["url"]))

    wiki.at_css('#biobody').content
    # Nokogiri::HTML.parse(input_string).css('p').first.text
    # use .content.strip to get rid of html elements
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
