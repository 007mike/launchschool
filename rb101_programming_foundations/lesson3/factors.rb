def factors(number)
  divisor = number
  factors = []

  loop do
    if divisor > 0
      factors << number / divisor if number % divisor == 0
      divisor -= 1
    elsif divisor <= 0
      return factors
    end
  end
end
        
puts factors(81)