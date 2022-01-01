#calculator.rb
# Ask the user for two numbers
# Ask the user what operation to perform: add, subtract, divide or multiply
# display the results

Kernel.puts("Welcome to Calculator")

Kernel.puts("What is the first number?")
number1 = Kernel.gets().chomp()

Kernel.puts("What is the second number")
number2 = Kernel.gets().chomp()

Kernel.puts("What operation to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i + number2.to_i
elsif operator == '2'
  result = number1.to_i - number2.to_i
elsif operator == '3'
  result = number1.to_i * number2.to_i
else
  result = number1.to_f / number2.to_f
end

Kernel.puts("The result is #{result}")

