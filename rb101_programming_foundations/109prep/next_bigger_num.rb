# create a ethod that takes a positive integer number and returns the next bigger number
# formed by the same digits

def next_bigger_num(i)
  max_i = i.digits.sort.reverse.map(&:to_s).join.to_i
  (i + 1).upto(max_i) do |num|
    return num if num.digits.sort == i.digits.sort
  end
  -1
end


p next_bigger_num(9) #== -1
p next_bigger_num(12) # == 21
p next_bigger_num(513) # == 531
p next_bigger_num(2017) # == 2017
p next_bigger_num(111)
p next_bigger_num(531)
p next_bigger_num(123456789)