# input is a string
# output is a new string with each word of the original string capitalized
# requirements: create a method titleize that takes a string as a parameter
# 1. take original string and split it into words
# 2. iterate over each word and capitalize it
# 3. inject the capitalized word into the new string
# 4. join the elements of the new string into a sentence and return it

words = "this is michael's magic hour"

def titleize(sentence)
  capitized_words = []
  sentence.split.each do | word |
    capitized_words << word.capitalize
  end
  capitized_words.join(' ')
end

puts titleize(words)
