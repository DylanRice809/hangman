dictionary = File.open("google-10000-english-no-swears.txt", "r")
dictionary_contents = dictionary.read


class Hangman
  def initialize (all_words)
    @word = all_words.split(" ").select { |element| element.length >= 5 && element.length <= 12 }.sample
    @strikes = 8
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def take_turn ()
    # allow the player to make a guess
    guess = gets.chomp!
    # verify if and where this letter takes place
    
    # if not, add a strike, and add to incorrect guesses
    # if yes, position the guesses appropriately in the correct_guesses array, then check win
end

new_game = Hangman.new(dictionary_contents)