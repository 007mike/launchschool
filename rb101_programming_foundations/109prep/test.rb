def shout(string)
  puts string.object_id
  string + "!!!"
  #string.upcase!
  puts string.object_id
end

sentence = "hello world"
shout(sentence)

puts sentence