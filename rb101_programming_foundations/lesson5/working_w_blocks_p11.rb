arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

multiples = arr.map do |sub_arr|
              sub_arr.select do |val|
                val % 3 == 0
              end
            end

p multiples