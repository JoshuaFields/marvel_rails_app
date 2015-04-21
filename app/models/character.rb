class Character < ActiveRecord::Base

  validates :character_name, presence: true

  def self.sort_abc
    array_abc = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("a", "b", "c")
        array_abc << hero
      end
    end
    array_abc
  end

  def self.sort_def
    array_def = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("d", "e", "f")
        array_def << hero
      end
    end
    array_def
  end

  def self.sort_ghi
    array_ghi = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("g", "h", "i")
        array_ghi << hero
      end
    end
    array_ghi
  end

  def self.sort_jkl
    array_jkl = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("j", "k", "l")
        array_jkl << hero
      end
    end
    array_jkl
  end

  def self.sort_mno
    array_mno = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("m", "n", "o")
        array_mno << hero
      end
    end
    array_mno
  end

  def self.sort_pqr
    array_pqr = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("p", "q", "r")
        array_pqr << hero
      end
    end
    array_pqr
  end

  def self.sort_stu
    array_stu = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("s", "t", "u")
        array_stu << hero
      end
    end
    array_stu
  end

  def self.sort_vwx
    array_vwx = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("v", "w", "x")
        array_vwx << hero
      end
    end
    array_vwx
  end

  def self.sort_yz
    array_yz = []
    Character.all.order(:character_name).each do |hero|
      if hero.character_name.downcase.start_with?("y", "z")
        array_yz << hero
      end
    end
    array_yz
  end

  def index_image
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

end
