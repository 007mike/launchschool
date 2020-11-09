#input - array 
#output - new array 

#rules - 
# 1. first array must not be modified
# 2. rotate array moving the first element to the end of the array
# 3. do not use rotate or rotate! methods

#approach
# 1. create a subarray using array reference from position 1 to the end of the array
# 2. inject the element at position 0 of the original array into the new array from 1.

def rotate_array(arr)
  arr[1..-1] << arr[0]
end


p rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
p rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
p rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
p rotate_array(x) == [2, 3, 4, 1]   # => true
p x == [1, 2, 3, 4]                 # => true