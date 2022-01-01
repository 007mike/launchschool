#calculator2.rb
# Ask the user for two numbers
# Ask the user what operation to perform: add, subtract, divide or multiply
# display the results

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when '1' then 'Adding'
  when '2' then 'Subtracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

prompt("Welcome to Calculator. Enter your name:")

name = ''

loop do
  name = Kernel.gets().chomp()
  
  if name.empty?()
    prompt("Please enter a valid name.")
  else
    break
  end
end

prompt("Hi, #{name}")

loop do # main loop
  number1 = ''
  number2 = ''

  loop do
    prompt("What is the first number?")
    number1 = Kernel.gets().chomp()

    break if valid_number?(number1)
    prompt "That doesn't look like a valid number."
  end

  loop do
    prompt("What is the second number")
    number2 = Kernel.gets().chomp()

    break if valid_number?(number2)
    prompt "That doesn't look like a valid number."
  end

  operator_prompt = <<-MSG
    What operation to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)
  
  operator = ''

  loop do
    operator = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operator)
    puts "Must choose 1, 2, 3 or 4."
  end

  prompt("#{operation_to_message(operator)} the numbers.")

  result =  case operator
            when '1' then number1.to_i + number2.to_i
            when '2' then number1.to_i - number2.to_i
            when '3' then number1.to_i * number2.to_i
            else          number1.to_f / number2.to_f
            end

  prompt("The result is #{result}")
  prompt("Do you want to perform another calculation? (Y to try agin)")
  answer = gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for trying out the calculator!")