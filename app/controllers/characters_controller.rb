require 'open-uri'

class CharactersController < ApplicationController

  def new
    @character = Character.new
  end

  def show
    unless params[:id] == nil
      @character = Character.find(params[:id])
      @character_api = MarvelApi.new(@character)
    else
      params[:id] = 1
      @character = Character.find(params[:id])
      @character_api = MarvelApi.new(@character)
    end
  end

  # possibly take this out. i may not use an index page
  def index
    @characters = Character.all
  end

end
