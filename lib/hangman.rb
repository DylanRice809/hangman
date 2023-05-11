dictionary = File.open("google-10000-english-no-swears.txt", "r")
dictionary_contents = dictionary.read

word = dictionary_contents.split(" ").select { |element| element.length >= 5 && element.length <= 12 }.sample
p word