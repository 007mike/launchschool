def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when '1'
    "Adding"
  when '2'
    "Subtracting"
  when '3'
    "Multiplying"
  when '4'
    "Dividing"
  end
end

prompt("Welcome to the CALCULATOR. Enter your name:")

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Make sure to enter your name.")
  else
    break
  end
end

prompt("Hi, #{name}")

loop do
  number1 = ''
  loop do
    prompt("Please enter the 1st number:")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("That doesn't look like a valid number.")
    end
  end

  number2 = ''
  loop do
    prompt("Please enter the 2nd number:")
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt("That doesn't look like a valid number.")
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) Add
    2) Substract
    3) Multiply
    4) Divide
  MSG

  prompt(operator_prompt)
  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, 4")
    end
  end

  result =  case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
            end
  prompt("#{operation_to_message(operator)} the two numbers.")
  prompt("The result is #{result}")
  prompt("Do you want to perform and another calculation? (Y) to try again.")
  continue = Kernel.gets().chomp()
  break unless continue.downcase().start_with?('y')
end

prompt("Thanks for using CALCULATOR #{name}")
