def camel(str)
  words = str.split(' ')
  counter = 0

  while counter < words.size
    words[counter] = words[counter].capitalize

    counter = counter + 1
  end

  words.join
end

sentence = 'The sky was blue'
p camel(sentence) # => 'TheSkyWasBlue'