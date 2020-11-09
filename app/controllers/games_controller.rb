require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = generate_grid(9)
  end

  def letter_check?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def generate_grid(grid_size)
  # TODO: generate random grid of letters
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @guess = params['word']
    @grid = params['grid']
    if letter_check?(@guess, @grid) && check_english_word?(@guess)
      @final_score = @guess.length
    else
      @final_score = 0
    end
    @final_score
    raise
  end
end
