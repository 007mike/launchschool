arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

odd_sort = arr.sort_by do |sub_arr|
             sub_arr.select do |int|
               int.odd?
             end
           end
p odd_sort