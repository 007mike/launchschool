# sort an array of strings by descending numeric value

arr = ['10', '11', '9', '7', '8']
arr_int = arr.map {|str| str.to_i}.sort.reverse
arr_sort = arr_int.map {|int| int.to_s}
p arr_sort

