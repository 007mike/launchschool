def snake(str)
  words = str.split
  current_word = 0

  loop do
    words[current_word].downcase!

    current_word += 1
    break if current_word >= words.size
  end

  words.join('_')
end

sentence = 'The sky was blue'
p snake(sentence) # => 'the_sky_was_blue'