require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @random_letters = ['a','d','e']
    @random_letters = ('a'..'z').to_a.sample(10)
  end

  def score
    p params[:word]
    p english_word?(params[:word])
    p letters_contained?(params[:word], params[:random_letters])
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def letters_contained?(word, grid)
    word.chars.all? { |letter| grid.include?(letter) }
  end
end
