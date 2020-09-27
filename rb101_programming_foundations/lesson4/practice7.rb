statement = "The Flintstones Rock"

letters = statement.split.join.split('')
frequency = {}

letters.each do | letter |
  if frequency.key?(letter)
    frequency[letter] += 1
  else 
    frequency[letter] = 1
  end
end

p frequency
