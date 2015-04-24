require 'open-uri'
require 'uri'
require 'mechanize'

class MarvelApi
  attr_reader :character, :data

  def initialize(character)
    @character = character
    @character_name = character.character_name.split(" ").join("%20")
    @character_id = character.marvel_id
  end

  def get_series
    count = 0
    series_array = []
    until count == 3
      series = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters/#{@character_id}/series?titleStartsWith=#{@character_name}&orderBy=startYear&limit=3&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][count]
      series_array << series
      count += 1
    end
    series_array
  end

  def get_newest
    count = 0
    series_array = []
    until count == 2
      series = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters/#{@character_id}/series?titleStartsWith=#{@character_name}&orderBy=-startYear&limit=2&apikey=#{public_key}&ts=#{timestamp}&hash=#{encrypt_request}")["data"]["results"][count]
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
    result = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["description"]

    if result.nil? || result == ""
      get_alt_bio
    else
      result
    end
  end

  def get_character_id
    HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["id"]
  end

  def get_character_image
    result = HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?name=#{@character_name.downcase}&ts=#{timestamp}&apikey=#{public_key}&hash=#{encrypt_request}")["data"]["results"][0]["thumbnail"]

    if result.nil? && get_alt_character_image.nil?
      "image_not_available.jpg"
    else
      result["path"] + ".jpg"
    end
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
      "image_not_available.jpg"
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

  def get_alt_character_image
    mechanize = Mechanize.new
    page = mechanize.get(MarvelApi.new(@character).get_wiki)
    link1 = page.link_with(dom_class: 'image')
    page = link1.click

    link2 = page.link_with(text: "Full resolution")
    if link2.nil?
      nil
    else
      page2 = link2.click
      page2.uri
    end
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
