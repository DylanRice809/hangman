dictionary = File.open("google-10000-english-no-swears.txt", "r")
dictionary_contents = dictionary.read


class Hangman
  def initialize (all_words)
    @word = all_words.split(" ").select { |element| element.length >= 5 && element.length <= 12 }.sample
    @strikes = 8
    @correct_guesses = Array.new(@word.length, "_")
    @incorrect_guesses = []
  end

  private
  def find_all_index (letter, word, indices_array=[])
    word.split("").each_with_index do |element, index|
      if (element == letter)
        indices_array << index
      end
    end
    indices_array  
  end
  
  def take_turn (word, guess_array, strikes, incorrect_guesses)
    guess = gets.chomp!
    if (word.include?(guess))
      find_all_index(guess, word).each { |index| guess_array[index] = guess }
      p guess_array
    else
      strikes -= 1
      incorrect_guesses << guess
    end
  end

  public
  def play_game ()
    while (@strikes > 0 && @correct_guesses.include?("_")) do
      take_turn(@word, @correct_guesses, @strikes, @incorrect_guesses)
    end
  end
end

new_game = Hangman.new(dictionary_contents)
new_game.play_game