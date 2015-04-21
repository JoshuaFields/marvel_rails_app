require 'open-uri'

class CharactersController < ApplicationController

  def new
    @character = Character.new
  end

  def show
      @character = Character.find(params[:id])
      @character_api = MarvelApi.new(@character)
      @characters = Character.all
  end

  # possibly take this out. i may not use an index page
  def index
    @characters = Character.all
  end

  def create
    @character = Character.find(params[:id])
  end
end
