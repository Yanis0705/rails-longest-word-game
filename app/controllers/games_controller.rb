require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = Array.new(9) { ('A'..'Z').to_a.sample }
    @letters = @grid.join(' ')
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @english_word = english_word?(@word)
    @include = included?(@word, @letters)
    @score_and_message = score_and_message(@word, @letters)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def score_and_message(word, grid)
    if included?(word.upcase, grid)
      if english_word?(word)
        "Congratulation #{word}, it' an english word"
      else
        "Sorry but #{word}, does not seem to be a valid english word..."
      end
    else
      "Sorry but #{word}, can't be built out of #{grid}"
    end
  end
end
