class CharactersController < ApplicationController

  def new
    @character = Character.new
  end

  def index
    @characters = Character.all
    unless params[:heroes] == nil
      @character = Character.find(params[:heroes]).character_name
      # @character_id_number = <<-eos
      # <%= HTTParty.get("http://gateway.marvel.com:80/v1/public/characters?
      # name=#{@character}&ts=#{timestamp}&apikey=#{public_key}&hash=#{hash}")
      # ["data"]["results"][0]["id"] %>
      # eos
    end
  end

end
