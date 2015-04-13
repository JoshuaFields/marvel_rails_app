module ApplicationHelper

  def hash
    @timestamp = "#{Time.now.to_i}"
    @private_key = ENV['MARVEL_PRIVATE_KEY']
    @public_key = ENV['MARVEL_PUBLIC_KEY']
    @hash = Digest::MD5.hexdigest("#{@timestamp}" + "#{@private_key}" + "#{@public_key}")
    @hash
  end

  def private_key
    @private_key = ENV['MARVEL_PRIVATE_KEY']
  end

  def public_key
    @public_key = ENV['MARVEL_PUBLIC_KEY']
  end

  def timestamp
    @timestamp = "#{Time.now.to_i}"
  end

  def character_id_number
    @character_id_number = HTTParty.get("http://gateway.marvel.com:80/v1/"\
    "public/characters?name=#{@character}&ts=#{timestamp}&apikey="\
    "#{public_key}&hash=#{hash}")["data"]["results"][0]["id"]
  end

  def character_bio
    @character_bio = HTTParty.get("http://gateway.marvel.com:80/v1/public/"\
    "characters?name=#{@character}&ts=#{timestamp}&apikey=#{public_key}"\
    "&hash=#{hash}")["data"]["results"][0]["description"]
  end

  def character_image
    @character_image = image_tag(HTTParty.get("http://gateway.marvel.com:80/v1/"\
    "public/characters?name=#{@character}&ts=#{timestamp}&apikey=#{public_key}&"\
    "hash=#{hash}")["data"]["results"][0]["thumbnail"]["path"].to_s + ".jpg")
  end

end
