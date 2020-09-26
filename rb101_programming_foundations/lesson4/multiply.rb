def multiply(numbers, multiplier)
  numbers.map {|x| x * multiplier}
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) # => [2, 8, 6, 14, 4, 12]
p my_numbers