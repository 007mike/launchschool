def substrings_test(string1, string2)
  string1.chars.each_cons(2) do |sub1|
    return true if string2.include?(sub1.join)
  end
  false
end


p substrings_test('abcwerwe', 'cmbcads')
p substrings_test('', 'as')
p substrings_test('1145632cb', 'sdfdsf14')