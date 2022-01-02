# calculator2.rb
# Ask the user for two numbers
# Ask the user what operation to perform: add, subtract, divide or multiply
# display the results
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yaml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def operation_to_message(op)
  case op
  when '1' then 'Adding'
  when '2' then 'Subtracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

prompt(MESSAGES['welcome'])

name = ''

loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(MESSAGES['name'])
  else
    break
  end
end

prompt("Hi, #{name}")

loop do # main loop
  number1 = ''
  number2 = ''

  loop do
    prompt(MESSAGES['first_num'])
    number1 = Kernel.gets().chomp()

    break if valid_number?(number1)
    prompt(MESSAGES['invalid_num'])
  end

  loop do
    prompt(MESSAGES['second_num'])
    number2 = Kernel.gets().chomp()

    break if valid_number?(number2)
    prompt(MESSAGES[invalid_num])
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
    prompt(MESSAGES['invalid_operator'])
  end

  prompt("#{operation_to_message(operator)} the numbers.")

  result =  case operator
            when '1' then number1.to_f + number2.to_f
            when '2' then number1.to_f - number2.to_f
            when '3' then number1.to_f * number2.to_f
            else          number1.to_f / number2.to_f
            end

  prompt("The result is #{result}")
  prompt(MESSAGES['another_calc'])
  answer = gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['thank_you'])
