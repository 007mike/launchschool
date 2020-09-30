arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]


new_arr = arr.map do |hsh|
            inc_hash = {}
            hsh.each do |key, val|
              inc_hash[key] = val + 1
            end
            inc_hash
          end

p new_arr
p arr