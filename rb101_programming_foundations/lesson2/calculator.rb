# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation
# display the result

Kernel.puts("Welcome to the CALCULATOR")

Kernel.puts("Please enter the 1st number:")
number1 = Kernel.gets().chomp()

Kernel.puts("Please enter the 2nd number:")
number2 = Kernel.gets().chomp()

Kernel.puts("What operation to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i() + number2.to_i()
elsif operator == '2'
  result = number1.to_i() - number2.to_i()
elsif operator == '3'
  result = number1.to_i() * number2.to_i()
else operator == '4'
  result = number1.to_f() / number2.to_f()
end

Kernel.puts("The result is #{result}")