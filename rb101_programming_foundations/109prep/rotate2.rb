#input - integer, integer
#output - new integer

#rules
# 1. if the n supplied is 1 return the original number
# 2. rotate_array from previous exercise is allowable
# 3. n is always a positive integer
# question? can we assume n is always <= the length of the supplied number? (assuming yes)

#approach
# 1. convert the supplied number into string
# 2. convert the converted string in an array of chars
# 3. send digits length of the array (from the end) of chars to rotate_array method
# 4. re assign the end of the array with the return value of rotate_array


def rotate_array(arr)
  arr[1..-1] << arr[0]
end

def rotate_rightmost_digits(num, digits)
  num_arr = num.to_s.chars
  num_arr[-digits..-1] = rotate_array(num_arr[-digits..-1])
  num_arr.join('').to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917