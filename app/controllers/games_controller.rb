require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10).join
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split("")
    @result = ''

    if includes_letters(@word, @letters) && real_word?(@word)
       @result = "Congratulations #{@word} is a valid english word!"
    else
       @result = "Sorry, but #{@word} can not be built out of offered letters."
    end       
  end

  def includes_letters(word, letters)
    word.split("") { |letter| letters.include? letter }
  end  

  def real_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

