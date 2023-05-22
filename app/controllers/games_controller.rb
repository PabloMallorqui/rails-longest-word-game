require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @random_letters = params[:random_letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    dictionary_entry = JSON.parse(user_serialized)

    @dictionary = dictionary_entry['found']

    if @dictionary && check_letters(@random_letters, @word)
      @message = "Congratulations! #{@word.upcase} is a valid english word!"
    elsif @dictionary == false
      @message = "Sorry but #{@word.upcase} does not seem to be a valid english word..."
    end
  end

  def check_letters(all_letters, word)
    word.all? do |letter|
      all_letters.include?(letter)
    end
  end
end
