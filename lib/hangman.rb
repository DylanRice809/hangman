dictionary = File.open("google-10000-english-no-swears.txt", "r")
dictionary_contents = dictionary.read

word = dictionary_contents.split(" ").sample
p word