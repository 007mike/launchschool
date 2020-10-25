def max_sequence(arr)
  results = []
  p arr.size
  (0...arr.size).each do |i|
    (i...arr.size).each do |j|
      results << arr[i..j].sum
    end
  end
  results.max
end


p max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) #== 6