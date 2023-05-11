require 'yaml'

dictionary = File.open("google-10000-english-no-swears.txt", "r")
dictionary_contents = dictionary.read
dictionary.rewind

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
  
  def take_turn (word, guess_array, incorrect_guesses)
    puts "Guess a letter: "
    guess = gets.chomp.downcase
    if (guess == "save")
      serialize()
    end
    if (word.include?(guess))
      find_all_index(guess, word).each { |index| guess_array[index] = guess }
      puts "There are #{find_all_index(guess, word).length} #{guess}s."
    else
      puts "There are no #{guess}s."
      @strikes = @strikes - 1
      incorrect_guesses << guess
    end
  end

  def serialize
    file = File.open('game.yml', 'w') do |f|
      YAML.dump(self, f)
    end
    file.close
    exit
  end

  public
  def play_game ()
    loop do 
      puts "Strikes remaining: #{@strikes}"
      puts "Incorrect guesses: #{@incorrect_guesses}"
      p @correct_guesses
      take_turn(@word, @correct_guesses, @incorrect_guesses) 
      puts "--------------------"
      if (!(@correct_guesses.include?("_")))
        puts "Congratulations! You won!"
        break
      elsif (@strikes == 0)
        puts "You lost. The word was #{@word}."
        break
      end
    end
  end
end

def deserialize
  File.open('game.yml', 'r') do |f|
    loaded_game = YAML.load(f, permitted_classes: [Hangman])
    loaded_game.play_game
  end
end

puts "Would you like to reload your most recent save?"
if (gets.chomp.downcase == "y")
  deserialize()
else
  new_game = Hangman.new(dictionary_contents)
  new_game.play_game
end