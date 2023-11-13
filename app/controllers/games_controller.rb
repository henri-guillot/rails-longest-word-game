require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @random_letters = ['a','d','e']
    @random_letters = ('a'..'z').to_a.sample(10)
  end

  def score()
    @answer=""
    p params[:word]
    p english_word?(params[:word])
    if english_word?(params[:word]) & letters_contained?(params[:word], params[:random_letters])
      @answer = "congrats!"
    elsif english_word?(params[:word])
      @answer = "you must include only given letters!"
    else
      @answer = "this is not an english word.."
    end
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
