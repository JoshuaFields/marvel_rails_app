require 'open-uri'
require 'uri'

class CharactersController < ApplicationController

  def show
      @character = Character.find(params[:id])
      @character_api = MarvelApi.new(@character)
      @characters = Character.all
  end

  def index

    @characters = Character.paginate(page: params[:page], per_page: 3).order("Random()")
  end

end
