arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

evens = []
evens = arr.select do |hsh|
          hsh.all? do |_ , value|
            value.all? do |int|
              int.even?
            end
          end
        end

p evens